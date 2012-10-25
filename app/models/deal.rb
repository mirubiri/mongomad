class Deal

  #Modules
  include Mongoid::Document

  #Relations
  belongs_to :deal_box
  embeds_one :agreement
  embeds_one :conversation, as: :polymorphic_conversation

  #Attributes

  #Validations

  #Behaviour
end
