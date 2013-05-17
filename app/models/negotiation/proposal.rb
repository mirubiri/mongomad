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

  #def actions_for(user)
  #  [
  #    :new, :sign if can_sign?(user),:unsign if can_unsign(user), :confirm if can_confirm(user)
  #  ]
  #end
  
  def money_holder
    return :nobody unless money.user_id?
    return :composer if money.user_id == user_composer_id
    return :receiver if money.user_id == user_receiver_id
  end

  def can_sign?(user,requirements={})
    super(requirements)
  end

  def can_unsign?(user,requirements={})
    super(requirements)
  end

  def can_confirm?(user,requirements={})
    super(requirements)
  end


end
