class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Denormalized
  # include ImageManagement::ImageHolder

  embedded_in :product_container, polymorphic: true
  embeds_one  :sheet, class_name:'ItemSheet', as: :sheet_container

  field :quantity, type: Integer

  # denormalize :name, :description, :image_fingerprint, from:'thing'

  validates_presence_of :sheet, :quantity

  validates :quantity, allow_nil: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

#   def thing
#     receiver.offer.user_receiver.things.find(thing_id)
#   end
end

