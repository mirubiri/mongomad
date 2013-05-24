class Negotiation::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation
  embeds_one  :composer, class_name: 'Negotiation::Proposal::Composer', cascade_callbacks: true
  embeds_one  :receiver, class_name: 'Negotiation::Proposal::Receiver', cascade_callbacks: true
  embeds_one  :money,    class_name: 'Negotiation::Proposal::Money', cascade_callbacks: true

  field :user_composer_id, type: Moped::BSON::ObjectId
  field :user_receiver_id, type: Moped::BSON::ObjectId

  accepts_nested_attributes_for :composer, :receiver, :money

  before_create :set_initial_state

  state_machine :confirmable_state, :initial => :confirmable do
    event :unconfirmable do
      transition :confirmable => :unconfirmable, :unless => :confirmed?
    end

    event :confirmable do
      transition :unconfirmable => :confirmable
    end
  end

  state_machine :state, :initial => nil do
    event :sign_receiver do
      transition :unsigned => :receiver_signed
    end

    event :confirm_composer do
      transition :receiver_signed => :composer_confirmed, :if => :confirmable?
    end

    event :confirm_receiver do
      transition :composer_signed => :receiver_confirmed, :if => :confirmable?
    end

    event :cancel_composer do
      transition [:unsigned, :composer_signed, :receiver_signed] => :composer_canceled
    end

    event :cancel_receiver do
      transition [:unsigned ,:composer_signed, :receiver_signed] => :receiver_canceled
    end
  end

  validates :composer,
   :receiver,
   :money,
   :user_composer_id,
   :user_receiver_id,
   :confirmable_state,
   presence: true

  def user_composer
    negotiation && negotiation.negotiators.find(user_composer_id)
  end

  def user_receiver
    negotiation && negotiation.negotiators.find(user_receiver_id)
  end

  def can_sign?(user)
    if (user_receiver_id == user.id) && (state == 'unsigned')
      return true
    else
      return false
    end
  end

  def can_confirm?(user)
    if (user_composer_id == user.id && state == 'receiver_signed') || (user_receiver_id == user.id && state == 'composer_signed')
      return true
    else
      return false
    end
  end

  def can_cancel?(user)
    if state == 'unsigned' || state == 'receiver_signed' || state == 'composer_signed'
      return true
    else
      return false
    end
  end

  private
  def set_initial_state
    if money.user_id.nil? || money.user_id == user_composer_id
      self.state = :composer_signed
    else
      self.state = :unsigned
    end
  end
end
