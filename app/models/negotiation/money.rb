module Negotiation
  class Money
    include Mongoid::Document

    embedded_in :offer

    field :user_id, type: Moped::BSON::ObjectId
    field :quantity, type: Integer

    validates :offer,
              :user_id,
              :quantity,
              presence: true

    validates :quantity,
              allow_nil: false,
              numericality: { only_integer: true,
                              greater_than: 0 }
  end
end