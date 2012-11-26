class Negotiation::Offer::Composer
      include Mongoid::Document

      embedded_in :offer
      embeds_many :products, cascade_callbacks: true
      embeds_one :image,class_name:"Image"

      field :user_id, type: Moped::BSON::ObjectId
      field :name, type: String

      validates :offer,
                :products,
                :user_id,
                :name,
                :image,
                presence: true
end