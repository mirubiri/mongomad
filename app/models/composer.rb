class Composer
  include Mongoid::Document
  embedded_in :offer
  embeds_one :product_box, as: :polymorphic_product_box
end
