class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :name
  field :description
  field :stock, type:Integer

  validates_presence_of :name, :description, :stock, :user

  validates :stock, allow_nil: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def pick(quantity)
  	Product.new(name:name,description:description,quantity:quantity) do |product|
      product.id=id
      product.owner_id=user.id
  	end
  end

  def sell(quantity)
    if stock >= quantity
      self.stock-=quantity
      save
    else
      false
    end
  end

  def supply(quantity)
    self.stock+=quantity
    save
  end

  def available?(quantity)
    if (self.stock == nil) || (quantity==0)
      false
    else
      quantity <= self.stock
    end
  end
end
