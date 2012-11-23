class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  embedded_in :message_parent, polymorphic: true
  has_mongoid_attached_file :image, preseve_files:true

  field :sender_id, type: Moped::BSON::ObjectId
  field :sender_name, type: String
  field :text, type: String

  validates :message_parent,
            :sender_id,
            :sender_name,
            :text,
            :image,
            presence: true
end