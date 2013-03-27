class Deal::Agreement::Conversation::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :conversation, class_name: "Deal::Agreement::Conversation"

  field :user_id, type: Moped::BSON::ObjectId
  field :text,    type: String

  validates :conversation,
    :user_id,
    :text,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }
end
