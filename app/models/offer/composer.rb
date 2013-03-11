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


  def add_products(products_params=[])
    composer_things = offer.user_composer.things
    products_params.each do |index|
      thing = composer_things.find(index[:thing_id])
      raise "thing is not valid" if thing == nil
      raise "quantity is not valid" if thind.quantity < index[:quantity]
      products.build(thing_id: index[:thing_id], quantity: index[:quantity])
    end
  end

  def self_update!
    update_user_data
    update_products
    self
  end

=begin
  def alter_contents(params=[])
    products.destroy
    add_products(params)
  end

  private
  def update_user_data
    self.name = offer.user_composer.profile.name
    self.image_name = offer.user_composer.profile.image_name
  end

  def update_products
    products.each do |product|
      product.self_update
    end
  end

  public

=end
end
