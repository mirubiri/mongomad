class Offer::Composer::Product
  include Mongoid::Document

  embedded_in :composer, class_name: "Offer::Composer"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  validates :composer,
    :thing_id,
    :name,
    :description,
    :quantity,
    :image_name,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self_update!
# puts self.thing_id
# puts self.composer
# puts "hola"
  thing = composer.offer.user_composer.things.find(self.thing_id)
    #puts composer.offer
   # thing = composer.offer.user_composer.things.find(self.thing_id)
    #raise "thing is not valid" if thing == nil
    #raise "quantity is not valid" if thing.stock < self.quantity
    reload if persisted?
    self.name = thing.name
    self.description = thing.description
    self.image_name = thing.image_name
    persisted? ? save : self
  end
end
