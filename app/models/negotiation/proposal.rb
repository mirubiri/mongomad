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

  validates :negotiation,
    :composer,
    :receiver,
    :money,
    :user_composer_id,
    :user_receiver_id,
    presence: true

  def user_composer
    negotiation.negotiators.find(user_composer_id)
  end

  def user_receiver
    negotiation.negotiators.find(user_receiver_id)
  end
end
