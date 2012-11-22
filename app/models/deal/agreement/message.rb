module Deal
  class Message
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :agreement

    field :sender_id, type: Moped::BSON::ObjectId
    field :sender_name, type: String
    field :text, type: String

    validates :agreement,
              :sender_id,
              :sender_name,
              :text,
              presence: true
  end
end