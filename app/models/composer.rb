class Composer

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :offer
  embeds_one :product_box, as: :polymorphic_product_box

  #Attributes

  #Validations

  #Behaviour
end
