class Offer::Composer
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  validates :offer,
    :products,
    :name,
    :image_name,
    presence: true

  def update_user_data
    reload if persisted?
    self.name = offer.user_composer.profile.name
    self.image_name = offer.user_composer.profile.image_name
  end

  def update_products
    products.each do |product|
      product.self_update!
    end
  end

  def self_update!
    update_user_data
    update_products
    persisted? ? save : self
  end

  def add_products(products_params=[])
    # composer_things = offer.user_composer.things
    products_params.each do |product|
      # thing = composer_things.find(product[:thing_id])
      # raise "thing is not valid" if thing == nil
      # raise "quantity is not valid" if thind.quantity < product[:quantity]
      products.build(thing_id: product[:thing_id], quantity: product[:quantity])
    end
    self.self_update!
  end
=begin


  def alter_contents(params=[])
    products.destroy
    add_products(params)
  end



  public

=end
end
