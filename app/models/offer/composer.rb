class Offer::Composer
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String
  has_mongoid_attached_file :image

  validates :offer,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end