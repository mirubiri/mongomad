class Negotiation::Proposal::Composer::Product
  include Mongoid::Document
  include Denormalized

  embedded_in :composer, class_name: 'Negotiation::Proposal::Composer'

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer
  field :image_url,   type: String

  denormalize :name, :description, :image_url, from:'thing'

  validates :thing_id,
    :name,
    :description,
    :quantity,
    :image_url,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def thing
    composer.user.things.find(thing_id)
  end
end
