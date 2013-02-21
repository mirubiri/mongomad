class Deal::Agreement::Proposal::Receiver
  include Mongoid::Document

  embedded_in :proposal, class_name: "Deal::Agreement::Proposal"
  embeds_many :products, class_name: "Deal::Agreement::Proposal::Receiver::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  validates :proposal,
    :products,
    :name,
    :image_name,
    presence: true
end
