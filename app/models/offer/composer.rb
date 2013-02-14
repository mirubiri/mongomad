class Offer::Composer
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

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
    self.image_name = offer.user_composer.profile.image_name
  end

  def update_products
    products.each do |product|
      product.self_update
    end
  end

  def self_update
    update_user_data
    update_products
    self
  end

end
