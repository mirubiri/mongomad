class Composer
  include Mongoid::Document

  embedded_in :composer_parent, polymorphic: true
  embeds_many :products, as: :product_parent, cascade_callbacks: true
  embeds_one :photo,class_name:"Image",as: :image_parent,cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name, type: String

  validates :composer_parent,
            :products,
            :user_id,
            :name,
            :photo,
            presence: true
end