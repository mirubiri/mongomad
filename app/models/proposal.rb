class Proposal

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_proposal, polymorphic: true

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations
  #TODO: Validations (or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
