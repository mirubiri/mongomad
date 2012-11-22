module Deal
  class Message
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :polymorphic_message, polymorphic: true

    field :sender_id, type: Moped::BSON::ObjectId
    field :sender_name, type: String
    field :text, type: String

    validates :polymorphic_message,
              :sender_id,
              :sender_name,
              :text,
              presence: true
  end
end