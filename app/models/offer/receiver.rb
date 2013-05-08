class Offer::Receiver
  include Mongoid::Document
  include ImageManagement::ImageHolder
  include Denormalized

  embedded_in :offer
  embeds_many :products, class_name: 'Offer::Receiver::Product', cascade_callbacks: true

  field :nick, type: String

  accepts_nested_attributes_for :products, allow_destroy:true

  denormalize :nick, :image_fingerprint, from:'offer.user_receiver.profile'

  validates :products,
    :nick,
    presence: true
end
