class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to  :user_composer, class_name: 'User', inverse_of: :sent_offers, autosave:false
  belongs_to  :user_receiver, class_name: 'User', inverse_of: :received_offers, autosave:false
  belongs_to  :negotiation
  embeds_many :user_sheets
  embeds_one  :proposal,      as: :proposal_container

  field :message
  field :state,  default:'new'

  validates_presence_of :user_composer, :user_receiver, :user_sheets, :proposal
  validates :message, length: { minimum: 1, maximum: 160 }
  validates_inclusion_of :state, in: ['new','negotiating','negotiated','ghosted','discarded']

  validate :check_composer_sheet,
           :check_receiver_sheet,
           :check_sheets_number

  def check_composer_sheet
    errors.add(:user_sheets, "Composer should have one user_sheet") unless user_sheets.find(_id:user_composer_id).size == 1
  end

  def check_receiver_sheet
    errors.add(:user_sheets, "Receiver should have one user_sheet") unless user_sheets.find(_id:user_receiver_id).size == 1
  end

  def check_sheets_number
    errors.add(:user_sheets, "Proposal should have only two user_sheets") unless user_sheets.size == 2
  end


  def state_machine(machine = nil)
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

  def negotiate
    state_machine.trigger(:negotiate)
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
    user_sheets.find(user_composer_id)
  end

  def receiver
    user_sheets.find(user_receiver_id)
  end
end
