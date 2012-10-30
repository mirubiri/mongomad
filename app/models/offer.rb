class Offer

  #Modules
  include Mongoid::Document

  #Relations
  belongs_to :offer_inbox
  belongs_to :offer_outbox
  embeds_one :composer
  embeds_one :receiver
  embeds_one :money, as: :polymorphic_money

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Relations)
  #TODO: Validations Relations(or DELETE)

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)
  validates :offer_inbox,
            :offer_outbox,
            :composer,
            :receiver,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
