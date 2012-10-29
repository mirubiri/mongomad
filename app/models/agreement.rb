class Agreement

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :deal
  embeds_many(:proposals)
  embeds_many(:messages)

  #Attributes

  #Validations

  #Behaviour
end
