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
    params.each do |index|
      products.build(thing_id: index[:thing_id], quantity: index[:quantity])
    end
  end

  def update_user_data
    self.name = offer.user_composer.profile.name
    self.image = offer.user_composer.profile.image
  end

  def update_products
    products.each do |product|
      product.auto_update
    end
  end

  def auto_update
    update_user_data
    update_products
    self
  end
end
