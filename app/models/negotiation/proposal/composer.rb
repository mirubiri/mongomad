class Negotiation::Proposal::Composer
  include Mongoid::Document

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Composer::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String
  field :image,   type: String

  validates :proposal,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end
