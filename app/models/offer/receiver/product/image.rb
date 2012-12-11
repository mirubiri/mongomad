class Offer::Receiver::Product::Image
  include Mongoid::Document

  embedded_in :product, class_name: "Offer::Receiver::Product"

  field :file, type: String

  validates :product,
            :file,
            presence: true
end
