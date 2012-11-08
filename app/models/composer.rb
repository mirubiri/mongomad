class Composer
  include Mongoid::Document

  embedded_in :polymorphic_composer, polymorphic: true
  embeds_many :products, as: :polymorphic_product

  field :user_id, type: Moped::BSON::ObjectId
  field :full_name, type: String

  validates :user_id,
            :full_name,
            :products,
            :polymorphic_composer,
            presence: true
end