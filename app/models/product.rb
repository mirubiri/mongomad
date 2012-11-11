class Product
  include Mongoid::Document

  embedded_in :polymorphic_product, polymorphic: true

  field :thing_id, type: Moped::BSON::ObjectId
  field :name, type: String
  field :description, type: String
  field :quantity, type: Integer, default: 1

  validates :polymorphic_product,
            :thing_id,
            :name,
            :description,
            :quantity,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
end