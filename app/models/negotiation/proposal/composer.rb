class Negotiation::Proposal::Composer
  include Mongoid::Document

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Composer::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader

  validates :proposal,
            :products,
            :name,
            :image,
            presence: true
end
