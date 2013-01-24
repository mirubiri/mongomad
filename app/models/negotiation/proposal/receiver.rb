class Negotiation::Proposal::Receiver
  include Mongoid::Document

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Receiver::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, UserImageUploader

  validates :proposal,
            :products,
            :name,
            :image,
            presence: true
end
