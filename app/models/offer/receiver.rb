class Offer::Receiver
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Receiver::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader

  validates :offer,
            :products,
            :name,
            :image,
            presence: true

  def add_products(params)
    params.keys.each do |key|
      products.build(thing_id: params[key][:thing_id], quantity: params[key][:quantity])
    end
  end

  def update_receiver_data
    self.name = self.offer.user_receiver.profile.name
    self.image = self.offer.user_receiver.profile.image
  end

  def update_receiver_products
    self.products.each do |product|
      product.auto_update
    end
  end

  def auto_update
    self.update_receiver_data
    self.update_receiver_products
    self
  end
end
