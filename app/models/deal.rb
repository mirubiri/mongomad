class Deal

  #Modules
  include Mongoid::Document

  #Relations
  belongs_to :deal_box
  embeds_one :agreement
  embeds_many :messages, as: :polymorphic_message

  #Attributes
  #TODO: Attributes (or DELETE)

  #Validations
  #TODO: Validations (or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
