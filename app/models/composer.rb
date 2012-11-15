class Composer
  include Mongoid::Document

  embedded_in :polymorphic_composer, polymorphic: true
  embeds_many :products, as: :polymorphic_product

  field :composer_id, type: Moped::BSON::ObjectId
  field :composer_name, type: String

  validates :polymorphic_composer,
            :products,
            :composer_id,
            :composer_name,
            presence: true
end