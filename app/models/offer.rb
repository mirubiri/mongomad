class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user_composer, class_name: 'User', inverse_of: :sent_offers, autosave:false
  belongs_to :user_receiver, class_name: 'User', inverse_of: :received_offers, autosave:false
  embeds_one :proposal, as: :proposal_container

  field :message
  field :state,  default:'new'

  validates_presence_of :user_composer, :user_receiver, :proposal
  validates :message, length: { minimum: 1, maximum: 160 }
  validates_inclusion_of :state, in: ['new','negotiating','negotiated','ghosted','discarded']

  def state_machine(machine=nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:negotiate, 'new' => 'negotiating',
                               'negotiated' => 'negotiating')

      machine.when(:negotiated, 'negotiating' => 'negotiated')

      machine.when(:ghost, 'new' => 'ghosted',
                           'negotiating' => 'ghosted',
                           'negotiated' => 'ghosted')

      machine.when(:discard, 'ghosted' => 'discarded')

      machine.on(:any) do
        self.state = @state_machine.state
      end
      machine
    end
  end

  #TODO: REVISAR CON OJO
  def negotiate
    if persisted?
      negotiation = Negotiation.create(users:[user_composer, user_receiver], proposals:[proposal])
      state_machine.trigger(:negotiate)
      negotiation
    else
      state_machine.trigger(:negotiate)
      false
    end
  end

  def negotiated
    state_machine.trigger(:negotiated)
  end

  def ghost
    state_machine.trigger(:ghost)
  end

  def discard
    state_machine.trigger(:discard)
  end

  def composer
    proposal.user_sheets.find(user_composer_id)
  end

  def receiver
    proposal.user_sheets.find(user_receiver_id)
  end
end
