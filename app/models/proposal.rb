class Proposal

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_proposal, polymorphic: true
  embeds_one :composer, as: :polymorphic_composer
  embeds_one :receiver, as: :polymorphic_receiver
  embeds_one :money, as: :polymorphic_money

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Relations)
  validates :composer,
            :receiver,
            presence: true

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end