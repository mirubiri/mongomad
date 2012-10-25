class Message

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :conversation

  #Attributes

  #Validations

  #Behaviour
end
