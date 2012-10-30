class Composer

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_composer, polymorphic: true
  embeds_many :products, as: :polymorphic_product

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Relations)
  validates :products,
            presence: true

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end