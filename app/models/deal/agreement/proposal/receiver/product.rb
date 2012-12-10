class Deal::Agreement::Proposal::Receiver::Product
  include Mongoid::Document

  embedded_in :receiver,         class_name: "Deal::Agreement::Proposal::Receiver"
  embeds_many :secondary_images, class_name: "Deal::Agreement::Proposal::Receiver::Product::Image", cascade_callbacks: true

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer, default: 1
  field :main_image,  type: String

  validates :receiver,
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