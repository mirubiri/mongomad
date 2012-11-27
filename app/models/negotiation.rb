class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, class_name: "Negotiation::Proposal", cascade_callbacks: true
  embeds_many :messages, class_name: "Negotiation::Message", cascade_callbacks: true

  field :token_owner_id, type: Moped::BSON::ObjectId
  field :token_state,    type: Boolean

  validates :proposals,
            :messages,
            :token_owner_id,
            :token_state,
            presence: true
end