class Money
  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_money, polymorphic: true

  #Attributes
  field :owner, type: Moped::BSON::ObjectId
  field :quantity, type: Integer

  #Validations (Attributes)
  validates :owner,
            :quantity,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: {only_integer: true,
                           greater_than: 0 }

  #Behaviour
  #TODO: Behaviour (or DELETE)
end