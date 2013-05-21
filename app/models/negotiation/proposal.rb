class Negotiation::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation
  embeds_one  :composer, class_name: 'Negotiation::Proposal::Composer', cascade_callbacks: true
  embeds_one  :receiver, class_name: 'Negotiation::Proposal::Receiver', cascade_callbacks: true
  embeds_one  :money,    class_name: 'Negotiation::Proposal::Money', cascade_callbacks: true

  field :user_composer_id, type: Moped::BSON::ObjectId
  field :user_receiver_id, type: Moped::BSON::ObjectId
  field :signer,           type: Moped::BSON::ObjectId

  accepts_nested_attributes_for :composer, :receiver, :money

  validates :composer,
    :receiver,
    :money,
    :user_composer_id,
    :user_receiver_id,
    presence: true

  def user_composer
    negotiation && negotiation.negotiators.find(user_composer_id)
  end

  def user_receiver
    negotiation && negotiation.negotiators.find(user_receiver_id)
  end

  state_machine :confirmable_state, :initial => :confirmable do
    event :unconfirmable do
      transition :confirmable => :unconfirmable, :unless => :confirmed?
    end

    event :confirmable do
      transition :unconfirmable => :confirmable
    end
  end

  after_save :set_initial_state, :if => :new_record?

  state_machine :state, :initial => nil do
    event :unsign do
      transition nil => :unsigned
    end

    event :sign_composer do
      transition nil => :composer_signed
    end

    event :sign_receiver do
      transition :unsigned => :receiver_signed
    end

    event :confirm_composer do
      transition :receiver_signed => :receiver_confirmed, :if => :confirmable?
    end

    event :confirm_receiver do
      transition :composer_signed => :composer_confirmed, :if => :confirmable?
    end

    event :cancel_composer do
      transition [:unsigned, :composer_signed, :receiver_signed] => :composer_canceled
    end

    event :cancel_receiver do
      transition [:unsigned ,:composer_signed, :receiver_signed] => :receiver_canceled
    end
  end

  def set_initial_state
    if money.user_id.nil? || money.user_id == user_composer_id
      sign_composer
    else
      unsign
    end
  end
end
