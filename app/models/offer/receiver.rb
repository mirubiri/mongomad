class Offer::Receiver
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Receiver::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String

  mount_uploader :image, UserImageUploader

  validates :offer,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end
