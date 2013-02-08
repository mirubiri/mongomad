class Negotiation::Proposal::Composer
  include Mongoid::Document

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Composer::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  validates :proposal,
            :products,
            :name,
            :image,
            presence: true

  def add_products(products)
    products.each do |product|
      new_product = Negotiation::Proposal::Composer::Product.new
      new_product.thing_id = product.thing_id
      new_product.name = product.name
      new_product.description = product.description
      new_product.quantity = product.quantity
      new_product.image = product.image
      self.products << new_product
    end
  end
end
