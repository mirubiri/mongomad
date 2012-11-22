module Deal
  class Composer
    include Mongoid::Document

    embedded_in :proposal, class_name: 'Deal::Proposal'
    embeds_many :products, class_name: 'Deal::Composer:Product', cascade_callbacks: true
    embeds_one :photo,class_name:"Image"

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