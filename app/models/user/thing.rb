class User::Thing
  include Mongoid::Document
  include ImageManagement::ImageHolder

  embedded_in :user

  field :name,        type: String
  field :description, type: String
  field :stock,       type: Integer

  #mount_uploader :image, ThingImageUploader

  validates :name,
    :description,
    :stock,
    presence: true

  validates :stock,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end