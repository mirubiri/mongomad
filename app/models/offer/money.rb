class Offer::Money
  include Mongoid::Document

  embedded_in :offer

  field :owner_id, type: Moped::BSON::ObjectId
  field :quantity, type: Integer

  validates :offer,
            :owner_id,
            :quantity,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than: 0 }
end