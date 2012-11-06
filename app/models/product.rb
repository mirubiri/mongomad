class Product
  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_product, polymorphic: true

  #Attributes
  field :thing_id, type: Moped::BSON::ObjectId
  field :name, type: String
  field :description, type: String
  field :quantity, type: Integer, default: 1

  #Validations (Attributes)
  validates :thing_id,
            :name,
            :description,
            :quantity,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }

  #Behaviour
  #TODO: Behaviour (or DELETE)
end