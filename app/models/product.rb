class Product
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :product_parent, polymorphic: true
  embeds_many :secondary_images, class_name: 'ImageShadow', as: :image_shadow_parent, inverse_of: :image_shadow_parent, cascade_callbacks: true
  has_mongoid_attached_file :main_image, preseve_files:true

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