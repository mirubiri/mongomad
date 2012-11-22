class Deal::Message
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :deal

    field :sender_id, type: Moped::BSON::ObjectId
    field :sender_name, type: String
    field :text, type: String

    validates :deal,
              :sender_id,
              :sender_name,
              :text,
              presence: true
end