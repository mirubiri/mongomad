class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :message_container, polymorphic: true

  field :user_id, type:Moped::BSON::ObjectId
  field :text

  validates_presence_of :user_id
  validates :text, length: { minimum: 1, maximum: 160 }
end
