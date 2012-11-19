class Composer
  include Mongoid::Document

  embedded_in :polymorphic_composer, polymorphic: true
  embeds_many :products, as: :polymorphic_product
  embeds_one :photo,class_name:"Image",as: :polymorphic_image,cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name, type: String

  validates :polymorphic_composer,
            :products,
            :user_id,
            :name,
            :photo,
            presence: true
end