class Offer::Composer
  include Mongoid::Document
  include Denormalized
  include ImageManagement::ImageHolder

  embedded_in :offer
  embeds_many :products, class_name: 'Offer::Composer::Product', cascade_callbacks: true

  field :name, type: String

  accepts_nested_attributes_for :products, allow_destroy:true

  denormalize :image_fingerprint, from:'offer.user_composer.profile'
  denormalize :name, from:'offer.user_composer'


  validates :products,
    :name,
    presence: true
end
