class Deal::Agreement::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :agreement, class_name: "Deal::Agreement"
  embeds_one  :composer,  class_name: "Deal::Agreement::Proposal::Composer", cascade_callbacks: true
  embeds_one  :receiver,  class_name: "Deal::Agreement::Proposal::Receiver", cascade_callbacks: true
  embeds_one  :money,     class_name: "Deal::Agreement::Proposal::Money", cascade_callbacks: true

  field :user_composer_id, type: Moped::BSON::ObjectId
  field :user_receiver_id, type: Moped::BSON::ObjectId

  accepts_nested_attributes_for :composer, :receiver, :money

  validates :agreement,
    :composer,
    :receiver,
    :money,
    :user_composer_id,
    :user_receiver_id,
    presence: true
end
