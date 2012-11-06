class Request
  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user

  #Attributes
  field :text, type: String
  field :creation_date, type: DateTime

  #Validations (Attributes)
  validates :text,
            :creation_date,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end