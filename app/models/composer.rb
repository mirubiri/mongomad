class Composer

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_composer, polymorphic: true
  embeds_many :products, as: :polymorphic_money

  #Attributes

  #Validations

  #Behaviour
end