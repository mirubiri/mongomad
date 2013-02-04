class Offer::Composer
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader

  validates :offer,
            :products,
            :name,
            :image,
            presence: true

  def add_products(params)
    params.each do |thing|
      products.build(thing_id: thing[:thing_id], quantity: thing[:quantity])
    end
  end

  def update_composer_data
    self.name = self.offer.user_composer.profile.name
    self.image = self.offer.user_composer.profile.image
  end

  def update_composer_products
    self.products.each do |product|
      product.auto_update
    end
  end

  def auto_update
    self.update_composer_data
    self.update_composer_products
    self
  end
end
