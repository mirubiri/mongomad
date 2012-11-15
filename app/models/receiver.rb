class Receiver
  include Mongoid::Document

  embedded_in :polymorphic_receiver, polymorphic: true
  embeds_many :products, as: :polymorphic_product

  field :receiver_id, type: Moped::BSON::ObjectId
  field :receiver_name, type: String

  validates :polymorphic_receiver,
            :products,
            :receiver_id,
            :receiver_name,
            presence: true
end