class Deal::Agreement::Proposal::Receiver::Product
  include Mongoid::Document

  embedded_in :receiver, class_name: 'Deal::Agreement::Proposal::Receiver'

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer
  field :image_url,   type: String

  validates :receiver,
    :thing_id,
    :name,
    :description,
    :quantity,
    :image_url,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
