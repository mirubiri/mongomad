class Negotiation::Proposal::Receiver::Product
  include Mongoid::Document

  embedded_in :receiver, class_name: "Negotiation::Proposal::Receiver"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  mount_uploader :image, ThingImageUploader, :mount_on => :image_name

  validates :receiver,
            :thing_id,
            :name,
            :description,
            :quantity,
            :image_name,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
end
