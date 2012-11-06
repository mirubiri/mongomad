class Composer
  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_composer, polymorphic: true
  embeds_many :products, as: :polymorphic_product

  #Attributes
  field :user_id, type: Moped::BSON::ObjectId
  field :full_name, type: String

  #Validations (Relations)
  validates :products,
            presence: true

  #Validations (Attributes)
  validates :user_id,
            :full_name,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end