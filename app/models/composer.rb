class Composer

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_composer, polymorphic: true
  embeds_many :products, as: :polymorphic_money

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations
  #TODO: Validations (or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end