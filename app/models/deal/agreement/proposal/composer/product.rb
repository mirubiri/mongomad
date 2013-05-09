class Deal::Agreement::Proposal::Composer::Product
  include Mongoid::Document
  include ImageManagement::ImageHolder

  embedded_in :composer, class_name: 'Deal::Agreement::Proposal::Composer'

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  validates :thing_id,
    :name,
    :description,
    :quantity,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
