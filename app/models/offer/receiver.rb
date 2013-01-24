class Offer::Receiver
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Receiver::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader

  validates :offer,
            :products,
            :name,
            :image,
            presence: true
end
