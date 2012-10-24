class ProductBox
  include Mongoid::Document
  embeds_many :products
  embedded_in :polymorphic_product_box, polymorphic: true
end
