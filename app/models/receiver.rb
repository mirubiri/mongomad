class Receiver

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_receiver, polymorphic: true
  embeds_many :products, as: :polymorphic_receiver

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations
  #TODO: Validations (or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
