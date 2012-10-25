class Money
  include Mongoid::Document
  embedded_in :offer
  field :money_owner, type: Moped::BSON::ObjectId
  field :quantity, type: BigDecimal

  validates :money_owner,
        :quantity,
        presence: true

  validates :quantity, allow_nil: false,
                       numericality: { greater_than: 0 }

end
