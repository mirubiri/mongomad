class Profile

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user
  embeds_one :photo

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Relations)
  validates :photo, presence: true

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end