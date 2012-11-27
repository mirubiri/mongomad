class User::Thing
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :user
  embeds_many :secondary_images, class_name: "User::Thing::Image", cascade_callbacks: true

  field :name,        type: String
  field :description, type: String
  field :stock,       type: Integer, default: 1
  has_mongoid_attached_file :image

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