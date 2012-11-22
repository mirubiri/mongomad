module Deal
  class Receiver
    include Mongoid::Document

    embedded_in :deal, class_name: 'Deal::Deal'
    embeds_many :products, class_name: 'Deal::Receiver::Product', cascade_callbacks: true
    embeds_one :photo,class_name:'Deal::Receiver::Image',cascade_callbacks: true


    field :user_id, type: Moped::BSON::ObjectId
    field :name, type: String

    validates :deal,
              :products,
              :user_id,
              :name,
              :photo,
              presence: true
  end
end