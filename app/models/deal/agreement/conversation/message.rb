class Deal::Agreement::Conversation::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :conversation, class_name: "Deal::Agreement::Conversation"

  field :user_id,   type: Moped::BSON::ObjectId
  field :nick,      type: String
  field :text,      type: String
  field :image_url, type: String

  validates :conversation,
    :user_id,
    :nick,
    :text,
    :image_url,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }
end
