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
    :image,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self_update
    thing = receiver.offer.user_receiver.things.find(self.thing_id)
    self.name = thing.name
    self.description = thing.description
    self.image_name = thing.image_name
    self
  end
end
