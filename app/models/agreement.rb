class Agreement

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :deal
  embeds_many :proposals
  embeds_many :messages

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Relations)
  #TODO: Validations Relations(or DELETE)

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
