class Offer::Receiver::Product
  include Mongoid::Document
  include Denormalized
  include ImageManagement::ImageHolder

  embedded_in :receiver, class_name: 'Offer::Receiver'

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  denormalize :name, :description, :image_fingerprint, from:'thing'

  validates :thing_id,
    :name,
    :description,
    :quantity,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def thing
    receiver.offer.user_receiver.things.find(thing_id)
  end
end
