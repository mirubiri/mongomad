class Deal::Agreement::Message
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    embedded_in :agreement, class_name: "Deal::Agreement"

    field :sender_id,   type: Moped::BSON::ObjectId
    field :sender_name, type: String
    field :text,        type: String
    has_mongoid_attached_file :image

    validates :agreement,
              :sender_id,
              :sender_name,
              :text,
              :image,
              presence: true
end