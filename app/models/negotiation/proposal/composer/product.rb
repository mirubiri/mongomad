class Negotiation::Proposal::Composer::Product
  include Mongoid::Document

  embedded_in :composer,         class_name: "Negotiation::Proposal::Composer"
  embeds_many :secondary_images, class_name: "Negotiation::Proposal::Composer::Product::Image", cascade_callbacks: true

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer, default: 1
  field :main_image,  type: String

  validates :composer,
            :thing_id,
            :name,
            :description,
            :quantity,
            :main_image,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
end