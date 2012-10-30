class Message

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_message, polymorphic: true

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
