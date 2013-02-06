class Deal::Agreement::Proposal::Composer
  include Mongoid::Document

  embedded_in :proposal, class_name: "Deal::Agreement::Proposal"
  embeds_many :products, class_name: "Deal::Agreement::Proposal::Composer::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  validates :proposal,
            :products,
            :name,
            :image,
            presence: true
end
