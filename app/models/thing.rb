class Thing
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :user
  has_mongoid_attached_file :main_image
  embeds_many :secondary_images,class_name: "Image", as: :image_parent, inverse_of: :image_parent, cascade_callbacks: true

  field :name, type: String
  field :description, type: String
  field :stock, type: Integer, default: 1

  validates :user,
            :name,
            :description,
            :stock,
            :main_image,
            presence: true

  validates :stock,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
end