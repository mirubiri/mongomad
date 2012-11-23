class Money
  include Mongoid::Document

  embedded_in :money_parent, polymorphic: true

  field :user_id, type: Moped::BSON::ObjectId
  field :quantity, type: Integer

  validates :money_parent,
            :user_id,
            :quantity,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than: 0 }
end