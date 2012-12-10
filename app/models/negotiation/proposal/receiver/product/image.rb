class Negotiation::Proposal::Receiver::Product::Image
  include Mongoid::Document

  embedded_in :product, class_name: "Negotiation::Proposal::Receiver::Product"

  field :file, type: String

  validates :product,
            :file,
            presence: true
end