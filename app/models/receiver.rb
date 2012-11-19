class Receiver
  include Mongoid::Document

  embedded_in :polymorphic_receiver, polymorphic: true
  embeds_many :products, as: :polymorphic_product

  field :user_id, type: Moped::BSON::ObjectId
  field :name, type: String

  validates :polymorphic_receiver,
            :products,
            :user_id,
            :name,
            presence: true
end