class Negotiation::Proposal::Composer::Product::Image
  include Mongoid::Document

  embedded_in :product, class_name: "Negotiation::Proposal::Composer::Product"

  field :file, type: String

  validates :product,
            :file,
            presence: true
end