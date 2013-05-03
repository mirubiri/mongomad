class Negotiation::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation
  embeds_one  :composer, class_name: 'Negotiation::Proposal::Composer', cascade_callbacks: true
  embeds_one  :receiver, class_name: 'Negotiation::Proposal::Receiver', cascade_callbacks: true
  embeds_one  :money,    class_name: 'Negotiation::Proposal::Money', cascade_callbacks: true

  field :user_composer_id, type: Moped::BSON::ObjectId
  field :user_receiver_id, type: Moped::BSON::ObjectId
  field :state,            type: Symbol, default: :new

  accepts_nested_attributes_for :composer, :receiver, :money

  validates :composer,
    :receiver,
    :money,
    :user_composer_id,
    :user_receiver_id,
    :state,
    presence: true

  validates :state,
    :inclusion => { :in => [:new, :signed_by_composer, :signed_by_receiver, :confirmed] }

  def user_composer
    negotiation && negotiation.negotiators.find(user_composer_id)
  end

  def user_receiver
    negotiation && negotiation.negotiators.find(user_receiver_id)
  end
end
