class Money

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :offer

  #Attributes
  field :money_owner, type: Moped::BSON::ObjectId
  field :quantity, type: BigDecimal

  #Validations
  validates :money_owner,
            :quantity,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { greater_than: 0 }

#Behaviour
end
