class Offer::Receiver
  include Mongoid::Document
  include Denormalized

  embedded_in :offer
  embeds_many :products, class_name: 'Offer::Receiver::Product', cascade_callbacks: true

  field :nick,      type: String
  field :image_url, type: String

  accepts_nested_attributes_for :products, allow_destroy:true

  denormalize :nick, :image_url, from:'offer.user_receiver.profile'

  validates :products,
    :nick,
    :image_url,
    presence: true
end
