class Negotiation::Proposal::Composer::Product
  include Mongoid::Document

  embedded_in :composer, class_name: "Negotiation::Proposal::Composer"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer, default: 1

  mount_uploader :image, ThingImageUploader

  validates :thing_id,
            :name,
            :description,
            :quantity,
            :image,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
end
