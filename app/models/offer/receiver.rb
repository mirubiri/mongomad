module Offer
    class Receiver
      include Mongoid::Document

      embedded_in :offer
      embeds_many :products, cascade_callbacks: true
      embeds_one :image, cascade_callbacks: true


      field :user_id, type: Moped::BSON::ObjectId
      field :name, type: String

      validates :offer,
                :products,
                :user_id,
                :name,
                :image,
                presence: true
    end
end