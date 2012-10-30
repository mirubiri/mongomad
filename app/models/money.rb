class Money

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_money, polymorphic: true

  #Attributes
  field :money_owner, type: Moped::BSON::ObjectId
  field :quantity, type: BigDecimal

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)
  validates :money_owner,
            :quantity,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { greater_than: 0 }

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
