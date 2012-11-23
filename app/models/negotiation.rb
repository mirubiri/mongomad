class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, as: :proposal_parent,cascade_callbacks: true
  embeds_many :messages, as: :message_parent

  field :token_user_id, type: Moped::BSON::ObjectId
  field :token_state, type: Boolean

  validates :proposals,
            :messages,
            :token_user_id,
            :token_state,
            presence: true
end