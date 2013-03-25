class Negotiation::Proposal::Composer::Product
  include Mongoid::Document

  embedded_in :composer, class_name: "Negotiation::Proposal::Composer"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer

  mount_uploader :image, ThingImageUploader, :mount_on => :image_name

  validates :composer,
    :thing_id,
    :name,
    :description,
    :quantity,
    :image_name,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

=begin
  def self_update
    thing = User.find(composer.proposal.user_composer_id).things.find(self.thing_id)
    self.name = thing.name
    self.description = thing.description
    self.image_name = thing.image_name
    self
  end
=end
end
