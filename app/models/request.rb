class Request
  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embedded_in :user

  #Attributes
  field :text, type: String

  #Validations (Relations)
  validates :user,
            presence: true

  #Validations (Attributes)
  validates :text,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end