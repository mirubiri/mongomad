class User::Thing
  include Mongoid::Document

  embedded_in :user
  embeds_one :main_image, cascade_callbacks: true

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