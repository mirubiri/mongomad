class Negotiation::Proposal::Composer
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Composer::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String
  has_mongoid_attached_file :image

  validates :proposal,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end