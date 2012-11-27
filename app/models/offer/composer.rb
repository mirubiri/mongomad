class Offer::Composer
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :composer_id,   type: Moped::BSON::ObjectId
  field :composer_name, type: String
  has_mongoid_attached_file :image

  validates :offer,
            :products,
            :composer_id,
            :composer_name,
            :image,
            presence: true
end