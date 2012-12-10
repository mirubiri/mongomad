class Deal::Agreement::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  embedded_in :agreement, class_name: "Deal::Agreement"

  field :user_id,   type: Moped::BSON::ObjectId
  field :user_name, type: String
  field :text,      type: String
  has_mongoid_attached_file :image

  validates :agreement,
            :user_id,
            :user_name,
            :text,
            :image,
            presence: true
end