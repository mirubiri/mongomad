class Deal::Message
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    embedded_in :deal

    field :sender_id,   type: Moped::BSON::ObjectId
    field :sender_name, type: String
    field :text,        type: String
    has_mongoid_attached_file :image

    validates :deal,
              :sender_id,
              :sender_name,
              :text,
              :image,
              presence: true
end