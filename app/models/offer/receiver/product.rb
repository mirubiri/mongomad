class Offer::Receiver::Product
  include Mongoid::Document
  include Denormalized

  embedded_in :receiver, class_name: "Offer::Receiver"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  denormalize :name, :description, :image_name, from:'thing'

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

  def thing
    receiver.offer.user_receiver.things.find(thing_id)
  end
end
