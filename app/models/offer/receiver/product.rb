class Offer::Receiver::Product
  include Mongoid::Document

  embedded_in :receiver, class_name: "Offer::Receiver"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  mount_uploader :image, ThingImageUploader

  validates :receiver,
            :thing_id,
            :name,
            :description,
            :quantity,
            :image,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }

  def to_negotiation_proposal_receiver_product
    product = Negotiation::Proposal::Receiver::Product.new
    product.thing_id = self.thing_id
    product.name = self.name
    product.description = self.description
    product.quantity = self.quantity
    product.image = File.open(self.image.path)
    product
  end

  def auto_update
    thing = receiver.offer.user_receiver.things.find(self.thing_id)
    self.name = thing.name
    self.description = thing.description
    self.image = thing.image
    self
  end
end
