class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :message_parent, polymorphic: true

  field :sender_id, type: Moped::BSON::ObjectId
  field :sender_name, type: String
  field :text, type: String

  validates :message_parent,
            :sender_id,
            :sender_name,
            :text,
            presence: true
end