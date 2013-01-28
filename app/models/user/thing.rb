class User::Thing
  include Mongoid::Document

  embedded_in :user

  field :name,        type: String
  field :description, type: String
  field :stock,       type: Integer, default: 1

  mount_uploader :image, ThingImageUploader

  validates :user,
            :name,
            :description,
            :stock,
            :image,
            presence: true

  validates :stock,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }

  def to_product(quantity)
    raise StandardError, 'Quantity not valid' if quantity <= 0
    raise StandardError, 'Not enough stock avaliable' if self.stock < quantity 
    product = Offer::Composer::Product.new
    product.thing_id = self._id
    product.name = self.name
    product.description = self.description
    product.quantity = quantity
    product.image = File.open(self.image.path) 
    product
  end                           
end
