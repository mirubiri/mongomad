class Negotiation::Message
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    embedded_in :negotiation

    field :sender_id,   type: Moped::BSON::ObjectId
    field :sender_name, type: String
    field :text,        type: String
    has_mongoid_attached_file :image

    validates :negotiation,
              :sender_id,
              :sender_name,
              :text,
              :image,
              presence: true
end