class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users

  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container

  field :previous_state, type:Array
  field :state, type:Array

  validates_presence_of :proposals, :messages, :state

  validate :check_state_before_persisted,
           :check_state_after_persisted,
           :check_state_multiple_values,
           :check_state_has_valid_value

  def cash?
    proposal.cash?
  end

  def cash_owner
    proposal.goods.type(Cash).first.owner_id
  end

  def proposal
    proposals.last
  end

  def composer
    proposal.composer_id
  end

  def receiver
    proposal.receiver_id
  end

  def initial_state
    if cash? && cash_owner == composer then
      self.state = ['unsigned']      
    else 
      self.state=[composer,'signed']
    end
  end

  def statemachine
    @statemachine ||= begin
      fsm = MicroMachine.new(state || initial_state )

      unsigned=['unsigned']
      composer_signed=[composer,'signed']
      receiver_signed=[receiver,'signed']
      composer_confirmed=[composer,'confirmed']
      receiver_confirmed=[receiver,'confirmed']
      receiver_rejected=[receiver,'rejected']
      nostock = ['nostock']

      fsm.when([receiver,:sign], unsigned => receiver_signed   )
      fsm.when([composer,:confirm], receiver_signed => composer_confirmed )
      fsm.when([receiver,:confirm], composer_signed => receiver_confirmed )
      fsm.when([receiver,:reject], unsigned => receiver_rejected )
      fsm.when([:nostock], unsigned => nostock, composer_signed => nostock, receiver_signed => nostock )
      fsm.when([:restock], nostock => previous_state )

      fsm.on(:any) do
        self.previous_state=state
        self.state = @statemachine.state
        fsm.when([:restock], nostock => previous_state )
      end

      fsm
    end
  end

  def sign
    _statemachine
  end

  def confirm
  end

  def reject 
  end

  def nostock
  end

  def restock
  end

  private
  def check_state_before_persisted
    errors.add(:state, "State should be equal to initial_state before persisted") unless !persisted? && state == initial_state
  end
  def check_state_after_persisted
    errors.add(:state, "State should be different to initial_state after persisted") unless persisted? && state != initial_state
  end
  def check_state_multiple_values
    errors.add(:state, "State should have only one value") if state.length > 2
    errors.add(:state, "State should have only one value") if state.length == 1 && state.length[0].class == 'Array'
    errors.add(:state, "State should have only one value") if state.length == 1 && state.length[0].class == 'Array' && state.length[1].class == 'Array'
  end
  def check_state_has_valid_value
    true
  end
end
