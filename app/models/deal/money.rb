module Deal
  class Money
    include Mongoid::Document

    embedded_in :polymorphic_money, polymorphic: true

    field :user_id, type: Moped::BSON::ObjectId
    field :quantity, type: Integer

    validates :polymorphic_money,
              :user_id,
              :quantity,
              presence: true

    validates :quantity,
              allow_nil: false,
              numericality: { only_integer: true,
                              greater_than: 0 }
  end
end