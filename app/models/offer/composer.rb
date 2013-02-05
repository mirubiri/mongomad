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
    puts "---------------------------------------"



    params.each do |index|
      #puts index
      #puts index[:thing_id]
      #puts index[:quantity]
      puts "PRODUCTO CREADO!"
      products.build(thing_id: index[:thing_id], quantity: index[:quantity])
    end
        puts "---------------------------------------"
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
