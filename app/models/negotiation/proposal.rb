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

  state_machine :state, :initial => :unsigned do
    event :sign do
      transition :unsigned => :signed
    end

    event :unsign do
      transition :signed => :unsigned
    end

    event :confirm do
      transition :signed => :confirmed, :if => :confirmable?
    end
  end

  def valid_user?(user_id)
   (user_id == user_composer_id) || (user_id == user_receiver_id)
  end

  def sign(user_id,*args)
    self.signer = user_id if valid_user?(user_id)
    return false if signer.nil?
    super
  end

  def unsign(user_id,*args)
    self.signer = nil if signer == user_id
    return false if signer?
    super
  end
end
