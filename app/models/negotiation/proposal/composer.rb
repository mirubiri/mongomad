class Negotiation::Proposal::Composer
  include Mongoid::Document
  include Denormalized

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Composer::Product", cascade_callbacks: true

  field :nickname, type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  accepts_nested_attributes_for :products

  denormalize :nickname, :image_name

  validates :proposal,
    :products,
    :nickname,
    :image_name,
    presence: true
=begin
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

  def add_products(params=[])
    params.each do |index|
      products.build(thing_id: index[:thing_id], quantity: index[:quantity])
    end
  end

  private
  def update_user_data
    self.name = User.find(proposal.user_composer_id).profile.name
    self.image_name = User.find(proposal.user_composer_id).profile.image_name
  end

  def update_products
    products.each do |product|
      product.self_update
    end
  end

  public
  def self_update
    update_user_data
    update_products
    self
  end
=end
end
