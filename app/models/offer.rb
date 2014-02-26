class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to  :user_composer, class_name: 'User', inverse_of: :sent_offers, autosave:false
  belongs_to  :user_receiver, class_name: 'User', inverse_of: :received_offers, autosave:false
  belongs_to  :negotiation
  embeds_many :user_sheets
  embeds_one  :proposal,      as: :proposal_container

  field :message
  field :state,            default:'on_sale'
  field :discarded,        type:Boolean, default:false
  field :negotiating,      type:Boolean, default:false
  field :negotiated_times, type:Integer, default:0

  validates_presence_of :user_composer, :user_receiver, :user_sheets, :proposal, :discarded, :negotiating, :negotiated_times
  validates_length_of :message, minimum: 1, maximum: 160
  validates_inclusion_of :state, in: ['on_sale','withdrawn','sold']
  validates_numericality_of :negotiated_times, greater_than_or_equal_to: 0

  validate :check_user_equality,
           :check_number_of_sheets,
           :check_composer_sheet,
           :check_receiver_sheet,
           :check_orphan_proposal

  private
  def check_user_equality
    errors.add(:users, "Composer and receiver should not be equal.") unless user_composer_id != user_receiver_id
  end

  def check_number_of_sheets
    errors.add(:user_sheets, "Offer should have only two user_sheets.") unless user_sheets.size == 2
  end

  def check_composer_sheet
    errors.add(:user_sheets, "Offer should have one user_sheet for composer.") unless user_sheets.where(_id:user_composer_id).size == 1
  end

  def check_receiver_sheet
    errors.add(:user_sheets, "Offer should have one user_sheet for receiver.") unless user_sheets.where(_id:user_receiver_id).size == 1
  end

  def check_orphan_proposal
    errors.add(:proposal, "Proposal should be owned by both users.") unless (proposal.composer_id == user_composer_id) && (proposal.receiver_id == user_receiver_id)
  end

  public
  def composer
    user_sheets.find(user_composer_id)
  end

  def receiver
    user_sheets.find(user_receiver_id)
  end

  def state_machine(machine = nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:withdraw, 'on_sale' => 'withdrawn')
      machine.when(:sell, 'on_sale' => 'sold')

      machine.on(:any) do
        self.state = @state_machine.state
      end
      machine
    end
  end

  def withdraw
    state_machine.trigger(:withdraw)
  end

  def sell
    state_machine.trigger(:sell)
  end

  def discarded?
    discarded
  end

  def discard
    discarded ? false : begin
      self.discarded = true
      true
    end
  end

  def negotiating?
    negotiating
  end
end
