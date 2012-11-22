class Negotiation::Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :offers, cascade_callbacks: true
  embeds_many :messages

  field :token_user_id, type: Moped::BSON::ObjectId
  field :token_state, type: Boolean

  validates :offers,
            :messages,
            :token_user_id,
            :token_state,
            presence: true
end