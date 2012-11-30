class Negotiation::Proposal::Receiver::Product::Image
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :product, class_name: "Negotiation::Proposal::Receiver::Product"

  has_mongoid_attached_file :file

  validates :product,
            :file,
            presence: true
end