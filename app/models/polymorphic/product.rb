class Product
  include Mongoid::Document
  include Mongoid::Timestamps

#   include Denormalized
#   include ImageManagement::ImageHolder

  embedded_in :polymorphic_product, polymorphic: true
  embeds_one :sheet

#   field :thing_id,    type: Moped::BSON::ObjectId
#   field :name,        type: String
#   field :description, type: String
#   field :quantity,    type: Integer

#   denormalize :name, :description, :image_fingerprint, from:'thing'

  validates :sheet,
#     :name,
#     :description,
#     :quantity,
    presence: true

#   validates :quantity,
#     allow_nil: false,
#     numericality: { only_integer: true, greater_than_or_equal_to: 0 }

#   def thing
#     receiver.offer.user_receiver.things.find(thing_id)
#   end
end
