class Negotiation
  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embeds_many :proposals, as: :polymorphic_proposal
  embeds_many :messages, as: :polymorphic_message

  #Attributes
  field :token_owner, type: Moped::BSON::ObjectId
  field :token_state, type: Boolean

  #Validations (Relations)
  validates :proposals,
            :messages,
            presence: true

  #Validations (Attributes)
  validates :token_owner,
            :token_state,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end