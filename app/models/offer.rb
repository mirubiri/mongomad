class Offer
  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embeds_one :composer, as: :polymorphic_composer
  embeds_one :receiver, as: :polymorphic_receiver
  embeds_one :money, as: :polymorphic_money

  #Attributes
  field :initial_message, type: String

  #Validations (Relations)
  validates :composer,
            :receiver,
            presence: true

  #Validations (Attributes)
  validates :initial_message,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end