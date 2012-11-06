class Product

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_product, polymorphic: true

  #Attributes
  #TODO: Attributes (or DELETE)
  field :thing_id, type: Moped::BSON::ObjectId
  field :name, type: String
  field :description, type: String
  field :quantity, type: Integer, default: 1

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)
  validates :thing_id,
            :name,
            :description,
            :quantity,
            presence:true

  validates :quantity,
            allow_nil: false,
            numericality: { greater_than: 0,
                            only_integer: true }

  #Behaviour
  #TODO: Behaviour (or DELETE)

end