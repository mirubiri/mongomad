class Profile

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user

  #Attributes

  #Validations

  #Behaviour
end
