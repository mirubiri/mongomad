class Conversation

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_conversation, polymorphic: true
  embeds_many :messages

  #Attributes

  #Validations

  #Behaviour
end
