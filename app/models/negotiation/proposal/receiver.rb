class Negotiation::Offer::Receiver
  include Mongoid::Document

  embedded_in :receiver
  embeds_many :products, cascade_callbacks: true
  embeds_one :image


  field :user_id, type: Moped::BSON::ObjectId
  field :name, type: String

  validates :offer,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end