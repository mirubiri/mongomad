class Money
  include Mongoid::Document
  embedded_in :offer
  field :money_owner, type: Moped::BSON::ObjectId
  field :quantity, type: BigDecimal
end
