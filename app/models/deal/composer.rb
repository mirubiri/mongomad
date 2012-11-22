module Deal
  class Composer
    include Mongoid::Document

    embedded_in :offer, class_name: 'Deal::offer'
    embeds_many :products, class_name: 'Deal::Composer:Product', cascade_callbacks: true
    embeds_one :photo,class_name:"Image"

    field :user_id, type: Moped::BSON::ObjectId
    field :name, type: String

    validates :offer,
              :products,
              :user_id,
              :name,
              :photo,
              presence: true
  end
end