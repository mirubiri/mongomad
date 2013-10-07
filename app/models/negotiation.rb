class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users

  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container
  embeds_many :user_sheets, class_name:'UserSheet', as: :sheet_container

  field :previous_state,type:Array
  field :_state,type:Array

  validates_presence_of :proposals, :messages, :_state

  def cash?
    proposal.cash?
  end

  def cash_owner
    proposal.cash_owner
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
    [composer,'signed']
  end

  def _statemachine
    @_state ||= begin
      fsm = MicroMachine.new(_state || initial_state )

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
        self.previous_state=_state
        self._state = _statemachine.state
        fsm.when([:restock], nostock => previous_state )
      end

      fsm
    end
  end
end
