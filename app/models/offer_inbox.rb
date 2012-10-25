class OfferInbox

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user
  has_many :offers, autosave: true

  #Attributes

  #Validations

  #Behaviour
end
