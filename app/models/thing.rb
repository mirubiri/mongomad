class Thing
  include Mongoid::Document
  include Mongoid::Timestamps
#   include ImageManagement::ImageHolder

  embedded_in :user
  embeds_one  :sheet, as: :polymorphic_sheet

#   field :name,        type: String
#   field :description, type: String
#   field :stock,       type: Integer

  validates :sheet,
   #:name,
#     :description,
#     :stock,
    presence: true

#   validates :stock,
#     allow_nil: false,
#     numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end