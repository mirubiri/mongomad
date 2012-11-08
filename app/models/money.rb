class Money
  include Mongoid::Document

  embedded_in :polymorphic_money, polymorphic: true

  field :owner, type: Moped::BSON::ObjectId
  field :quantity, type: Integer

  validates :owner,
            :quantity,
            :polymorphic_money,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than: 0 }
end