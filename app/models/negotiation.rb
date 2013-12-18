class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users

  embeds_many :proposals, after_add: :initial_state, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container

  field :previous_state, type:Array
  field :state, type:Array

  validates_presence_of :proposals, :state

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

  def initial_state(proposal=nil)
    if cash? && cash_owner == composer then
      self.state = ['unsigned']
    else
      self.state=[composer,'signed']
    end
  end

  def statemachine
    @statemachine ||= begin
      fsm = MicroMachine.new(state)

      unsigned=['unsigned']
      composer_signed=[composer,'signed']
      receiver_signed=[receiver,'signed']
      composer_confirmed=[composer,'confirmed']
      receiver_confirmed=[receiver,'confirmed']
      composer_rejected=[composer,'rejected']
      receiver_rejected=[receiver,'rejected']
      nostock = ['nostock']

      fsm.when([receiver,:sign], unsigned => receiver_signed )

      fsm.when([composer,:confirm], receiver_signed => composer_confirmed )
      fsm.when([receiver,:confirm], composer_signed => receiver_confirmed )

      fsm.when([receiver,:reject], composer_signed => receiver_rejected,
                                   unsigned => receiver_rejected  )
      fsm.when([composer,:reject], receiver_signed => composer_rejected )

      fsm.when([:nostock], unsigned => nostock,
                           composer_signed => nostock,
                           receiver_signed => nostock )
      fsm.when([:restock], nostock => previous_state )

      fsm.on(:any) do
        self.previous_state=state
        self.state = @statemachine.state
      end

      fsm
    end
  end

  def sign(user_id)
    statemachine.trigger([user_id,:sign])
  end

  def confirm(user_id)
    statemachine.trigger([user_id,:confirm])
  end

  def reject(user_id)
    statemachine.trigger([user_id,:reject])
  end

  def nostock
    statemachine.trigger([:nostock])
  end

  def restock
    statemachine.trigger([:restock])
  end

  def actions_for(user_id)
    actions = Array.new
    if statemachine.trigger?([user_id,:sign])
      actions << :sign
    end
    if statemachine.trigger?([user_id,:confirm])
      actions << :confirm
    end
    if statemachine.trigger?([user_id,:reject])
      actions << :reject
    end
    actions
  end
end
