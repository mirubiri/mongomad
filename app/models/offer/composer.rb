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
      products.build(thing_id:thing[:thing_id],quantity:thing[:quantity])
    end
  end

  def data_update
    self.name=offer.user_composer.profile.name
    self.image=offer.user_composer.profile.image

    products.each do |product|
      thing=offer.user_composer.things.find(product.thing_id)
      product.name=thing.name
      product.description=thing.description
      product.image=thing.image
    end
  end
end
