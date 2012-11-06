class Agreement
  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :deal
  embeds_many :proposals, as: :polymorphic_proposal
  embeds_many :messages, as: :polymorphic_message

  #Validations (Relations)
  validates :proposals,
            :messages,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end