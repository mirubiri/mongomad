class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :name
  field :description
  field :stock, type:Integer

  validates_presence_of :name, :description, :stock

  validates :stock, allow_nil: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def as_product(params)
  	Product.new(name:name,description:description,quantity:params[:quantity]) do |product|
      product.id=id
      product.owner=user.id
  	end
  end
end
