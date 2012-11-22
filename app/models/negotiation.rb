module Negotiation
  class Negotiation
    include Mongoid::Document
    include Mongoid::Timestamps

    embeds_many :proposals, as: :polymorphic_proposal,cascade_callbacks: true
    embeds_many :messages, as: :polymorphic_message

    field :token_user_id, type: Moped::BSON::ObjectId
    field :token_state, type: Boolean

    validates :proposals,
              :messages,
              :token_user_id,
              :token_state,
              presence: true
  end
end