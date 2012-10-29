class Negotiation

  #Modules
  include Mongoid::Document

  #Relations
  embeds_many :proposals, as: :polymorphic_proposal
  embeds_many :messages, as: :polymorphic_message

  #Attributes

  #Validations

  #Behaviour
end
