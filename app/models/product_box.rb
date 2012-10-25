class ProductBox

  #Modules
  include Mongoid::Document

  #Relations
  embeds_many :products
  embedded_in :polymorphic_product_box, polymorphic: true

  #Attributes

  #Validations
  validates :products,
            presence: true
  #Behaviour
end
