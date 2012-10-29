class Proposal

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_proposal, polymorphic: true

  #Attributes

  #Validations

  #Behaviour
end
