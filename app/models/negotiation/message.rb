module Negotiation
  class Message
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :pnegotiation

    field :sender_id, type: Moped::BSON::ObjectId
    field :sender_name, type: String
    field :text, type: String

    validates :negotiation,
              :sender_id,
              :sender_name,
              :text,
              presence: true
  end
end