class Deal
  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embeds_one :agreement
  embeds_many :messages, as: :polymorphic_message

  #Validations (Relations)
  validates :agreement, presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end