class Offer::Composer
  include Mongoid::Document
  include Denormalized
  include ImageManagement::ImageHolder

  embedded_in :offer
  embeds_many :products, class_name: 'Offer::Composer::Product', cascade_callbacks: true

  field :nick, type: String

  accepts_nested_attributes_for :products, allow_destroy:true

  denormalize :nick, :image_fingerprint, from:'offer.user_composer.profile'

  validates :products,
    :nick,
    presence: true
end
