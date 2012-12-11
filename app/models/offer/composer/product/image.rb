class Offer::Composer::Product::Image
  include Mongoid::Document

  embedded_in :product, class_name: "Offer::Composer::Product"

  field :file, type: String

  validates :product,
            :file,
            presence: true
end
