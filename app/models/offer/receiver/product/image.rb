class Offer::Receiver::Product::Image
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :product, class_name: "Offer::Receiver::Product"

  has_mongoid_attached_file :file

  validates :product,
            :file,
            presence: true
end