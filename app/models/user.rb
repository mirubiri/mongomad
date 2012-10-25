class User

  #Modules
  include Mongoid::Document

  #Relations
  embeds_one :offer_inbox, cascade_callbacks: true
  embeds_one :offer_outbox, cascade_callbacks: true
  embeds_one :thing_box, cascade_callbacks: true
  embeds_one :negotiation_box, cascade_callbacks: true
  embeds_one :deal_box, cascade_callbacks: true
  embeds_one :profile, cascade_callbacks: true

  #Attributes

  #Validations

  #Behaviour
end
