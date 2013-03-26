class Negotiation::Conversation
  include Mongoid::Document

  embedded_in :negotiation
  embeds_many :messages, class_name: "Negotiation::Conversation::Message", cascade_callbacks: true

  # field :starter_name,  type: String
  # field :follower_name, type: String

  # mount_uploader :starter_image,  ProductImageUploader, :mount_on => :starter_image_name
  # mount_uploader :follower_image, ProductImageUploader, :mount_on => :follower_image_name

  accepts_nested_attributes_for :messages

  # denormalize :name, :image_name, from:'negotiators.first.profile'
  # denormalize :name, :image_name, from:'negotiators.last.profile'

  validates :negotiation,
    :messages,
    # :starter_name,
    # :follower_name,
    # :starter_image_name,
    # :follower_image_name,
    presence: true
end
