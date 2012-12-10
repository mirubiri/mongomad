class Offer::Composer
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String
  field :image,   type: String

  validates :offer,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end