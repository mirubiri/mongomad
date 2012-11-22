module Negotiation
  module Composer
    class Composer
      include Mongoid::Document

      embedded_in :proposal
      embeds_many :products, cascade_callbacks: true
      embeds_one :photo,class_name:"Image",

      field :user_id, type: Moped::BSON::ObjectId
      field :name, type: String

      validates :proposal,
                :products,
                :user_id,
                :name,
                :photo,
                presence: true
    end
  end
end