class Offer::Receiver::Product
  include Mongoid::Document

  embedded_in :receiver, class_name: "Offer::Receiver"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  validates :receiver,
    :thing_id,
    :name,
    :description,
    :quantity,
    :image_name,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.generate(params)
    Offer::Receiver::Product.new(
      thing_id:params[:thing_id],
      quantity:params[:quantity])
  end

  def alter_contents(params)
    if persisted?
      self.quantity = params[:quantity]
      save
    else
      false
    end
  end

  def self_update!
    users = User.where('things._id' => Moped::BSON::ObjectId(self.thing_id))
    raise "thing is not valid" unless users.count == 1
    user = users.first

    things = user.things.where('_id' => Moped::BSON::ObjectId(self.thing_id))
    raise "thing is not valid" unless things.count == 1
    thing = things.first

    raise "owner thing is not correct" unless receiver.offer.user_receiver._id == thing.user._id
    raise "quantity is not correct" if (self.quantity < 0 || self.quantity > thing.stock)

    reload if persisted?
    self.name = thing.name
    self.description = thing.description
    self.image_name = thing.image_name
    persisted? ? save : self
  end
end
