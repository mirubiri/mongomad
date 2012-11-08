class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :polymorphic_message, polymorphic: true

  field :sender_id, type: Moped::BSON::ObjectId
  field :sender_full_name, type: String
  field :text, type: String

  validates :sender_id,
            :sender_full_name,
            :text,
            :polymorphic_message,
            presence: true
end