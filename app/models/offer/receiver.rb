class Offer::Receiver
  include Mongoid::Document
  include Denormalized

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Receiver::Product", cascade_callbacks: true

  field :nickname, type: String
  field :image_url, type: String

  accepts_nested_attributes_for :products

  denormalize :nickname, :image_url, from:'offer.user_receiver.profile'

  validates :offer,
    :products,
    :nickname,
    :image_url,
    presence: true
end
