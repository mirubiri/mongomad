class Deal::Agreement::Proposal::Composer::Product::Image
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :product, class_name: "Deal::Agreement::Proposal::Composer::Product"

  has_mongoid_attached_file :file

  validates :product,
            :file,
            presence: true
end