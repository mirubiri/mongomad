class ProposalBox

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :negotiation
  embeds_many :proposals

  #Attributes

  #Validations

  #Behaviour
end
