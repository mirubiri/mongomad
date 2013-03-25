class Offer::Receiver
  include Mongoid::Document
  include Denormalized

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Receiver::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  accepts_nested_attributes_for :products

  denormalize :name, :image_name, from:'offer.user_receiver.profile'

  validates :offer,
    :products,
    :name,
    :image_name,
    presence: true
end
