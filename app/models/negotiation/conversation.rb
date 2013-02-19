class Negotiation::Conversation
  include Mongoid::Document

  embedded_in :negotiation

  field :user_name, type: String
  field :text,      type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  validates :negotiation,
    :user_name,
    :text,
    :image,
    presence: true
end
