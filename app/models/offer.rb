class Offer

  #Modules
  include Mongoid::Document

  #Relations
  belongs_to :offer_inbox
  belongs_to :offer_outbox
  embeds_one :composer
  embeds_one :receiver
  embeds_one :money

  #Attributes

  #Validations
  validates :offer_inbox,
            :offer_outbox,
            :composer,
            :receiver,
            presence: true

  #Behaviour
end
