class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, as: :polymorphic_proposal
  embeds_many :messages, as: :polymorphic_message

  field :token_owner, type: Moped::BSON::ObjectId
  field :token_state, type: Boolean

  validates :token_owner,
            :token_state,
            :proposals,
            presence: true
end