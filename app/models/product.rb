class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Denormalized
  # include ImageManagement::ImageHolder

  embedded_in :proposal

  field :name
  field :description
  field :_id,         type:Moped::BSON::ObjectId,default:nil
  field :owner_id,       type:Moped::BSON::ObjectId
  field :quantity,    type: Integer

  validates_presence_of :name,:description,:_id,:owner_id

  validates :quantity, allow_nil: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # denormalize :name, :description, :image_fingerprint, from:'thing'
#   def thing
#     receiver.offer.user_receiver.things.find(thing_id)
#   end

  def item
    Item.find(id)
  end

  def sell
    item.sell(quantity)
  end

  def available?
    return self.quantity <= self.item.stock
  end
end

