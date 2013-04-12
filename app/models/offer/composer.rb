class Offer::Composer
  include Mongoid::Document
  include Denormalized

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :nick,      type: String
  field :image_url, type: String

  accepts_nested_attributes_for :products

  denormalize :nick, :image_url, from:'offer.user_composer.profile'

  validates :offer,
    :products,
    :nick,
    :image_url,
    presence: true
end
