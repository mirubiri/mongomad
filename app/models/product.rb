class Product < Good
  include Mongoid::Timestamps
  # include Denormalized
  # include ImageManagement::ImageHolder

  field :name
  field :description
  field :_id,         type:Moped::BSON::ObjectId,default:nil
  field :owner_id,       type:Moped::BSON::ObjectId
  field :quantity,    type: Integer

  validates_presence_of :name,:description,:_id,:owner_id

  validates :quantity, allow_nil: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # denormalize :name, :description, :image_fingerprint, from:'item'
#   def item
#     receiver.offer.user_receiver.items.find(item_id)
#   end

  def item
    Item.find(id)
  end

  def sell
    self.item.sell(quantity)
  end

  def available?
    self.item.available?(self.quantity)
  end
end

