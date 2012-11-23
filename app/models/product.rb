class Product
  include Mongoid::Document

  embedded_in :product_parent, polymorphic: true
  embeds_one :main_image,class_name: "Image", as: :image_parent,cascade_callbacks: true

  field :thing_id, type: Moped::BSON::ObjectId
  field :name, type: String
  field :description, type: String
  field :quantity, type: Integer, default: 1

  validates :product_parent,
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