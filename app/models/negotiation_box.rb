class NegotiationBox

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user
  has_many :negotiations, autosave: true

  #Attributes

  #Validations

  #Behaviour
end
