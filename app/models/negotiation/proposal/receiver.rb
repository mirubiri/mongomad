class Negotiation::Proposal::Receiver
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Receiver::Product", cascade_callbacks: true

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