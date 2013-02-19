class Deal::Agreement::Conversation
  include Mongoid::Document

  embedded_in :agreement, class_name: "Deal::Agreement"

  field :user_name, type: String
  field :text,      type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  validates :agreement,
    :user_name,
    :text,
    :image,
    presence: true
end
