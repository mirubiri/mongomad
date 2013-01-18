class User::Thing
  include Mongoid::Document

  embedded_in :user


  field :name,        type: String
  field :description, type: String
  field :stock,       type: Integer, default: 1

  mount_uploader :image, ThingImageUploader


  validates :user,
            :name,
            :description,
            :stock,
            :image,
            presence: true

  validates :stock,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
end
