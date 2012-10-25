class DealBox

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user
  has_many :deals, autosave: true

  #Attributes

  #Validations

  #Behaviour
end
