class Negotiation

  #Modules
  include Mongoid::Document

  #Relations
  belongs_to :negotiation_box
  embeds_one :conversation, as: :polymorphic_conversation
  embeds_one :proposal_box

  #Attributes

  #Validations

  #Behaviour
end
