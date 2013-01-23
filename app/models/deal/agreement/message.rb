class Deal::Agreement::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :agreement, class_name: "Deal::Agreement"

  field :user_name, type: String
  field :text,          type: String

  mount_uploader :image, UserImageUploader

  validates :user_name,
            :agreement,
            :text,
            :image,
            presence: true
end
