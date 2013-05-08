class Deal::Agreement::Conversation::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include ImageManagement::ImageHolder

  embedded_in :conversation, class_name: 'Deal::Agreement::Conversation'

  field :user_id, type: Moped::BSON::ObjectId
  field :nick,    type: String
  field :text,    type: String

  validates :user_id,
    :nick,
    :text,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }
end
