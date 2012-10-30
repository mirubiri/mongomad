class Receiver

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_receiver, polymorphic: true
  embeds_many :products, as: :polymorphic_receiver

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations (Relations)
  #TODO: Validations Relations(or DELETE)

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
