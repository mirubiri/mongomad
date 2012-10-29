class Agreement

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :deal
  embeds_many :proposals
  embeds_many :messages

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations
  #TODO: Validations (or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
