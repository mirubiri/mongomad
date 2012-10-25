class Product

  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embedded_in :product_box

  #Attributes
  field :thing_id, type: Moped::BSON::ObjectId
  field :name, type: String
  field :description, type: String
  field :quantity, type: Integer, default: 1
  #field :main_photo_url
  #field :photos_url, type: Array

  #Validations
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
end
