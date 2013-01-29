class Negotiation::Proposal::Composer::Product
  include Mongoid::Document

  embedded_in :composer, class_name: "Negotiation::Proposal::Composer"

  field :thing_id,    type: Moped::BSON::ObjectId
  field :name,        type: String
  field :description, type: String
  field :quantity,    type: Integer, default: 1

  mount_uploader :image, ThingImageUploader

  validates :composer,
            :thing_id,
            :name,
            :description,
            :quantity,
            :image,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }

  def to_deal_agreement_proposal_composer_product
    product = Deal::Agreement::Proposal::Composer::Product.new
    product.thing_id = self.thing_id
    product.name = self.name
    product.description = self.description
    product.quantity = self.quantity
    product.image = File.open(self.image.path)
    product
  end
end
