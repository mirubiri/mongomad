class Message

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_message, polymorphic: true

  #Attributes

  #Validations

  #Behaviour
end
