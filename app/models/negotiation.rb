class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, as: :polymorphic_proposal
  embeds_many :messages, as: :polymorphic_message

  field :token_owner_id, type: Moped::BSON::ObjectId
  field :token_state, type: Boolean

  validates :proposals,
            :messages,
            :token_owner_id,
            :token_state,
            presence: true
end