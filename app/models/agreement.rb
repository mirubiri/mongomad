class Agreement

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :deal
  embeds_many :proposals, as: :polymorphic_proposal
  embeds_many :messages, as: :polymorphic_message

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Relations)
  validates :proposals,
            :messages,
            presence: true

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end