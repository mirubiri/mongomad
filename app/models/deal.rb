class Deal

  #Modules
  include Mongoid::Document

  #Relations
  belongs_to :deal_box
  embeds_one :agreement
  embeds_many :messages, as: :polymorphic_message

  #Attributes

  #Validations

  #Behaviour
end
