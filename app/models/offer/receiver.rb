class Offer::Receiver
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Receiver::Product", cascade_callbacks: true

  field :receiver_id,   type: Moped::BSON::ObjectId
  field :receiver_name, type: String
  has_mongoid_attached_file :image

  validates :offer,
            :products,
            :receiver_id,
            :receiver_name,
            :image,
            presence: true
end