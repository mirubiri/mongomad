class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :product_box
  field :name, type: String
  field :description, type: String
  field :quantity, type: Integer, default: 1
  field :thing_id
  #field :main_photo_url
  #field :photos_url, type: Array
  validates :description,
            :quantity,
            :name,
            :thing_id,
            presence:true
  validates :quantity,
             numericality: { greater_than:0, only_integer: true }, allow_nil:false


end
