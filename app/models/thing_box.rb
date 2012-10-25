class ThingBox

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user
  embeds_many :things

  #Attributes

  #Validations

  #Behaviour
end
