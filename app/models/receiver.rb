class Receiver
  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :polymorphic_receiver, polymorphic: true
  embeds_many :products, as: :polymorphic_product

  #Attributes
  field :user_id, type: Moped::BSON::ObjectId

  #Validations (Relations)
  validates :polymorphic_receiver,
            :products,
            presence: true

  #Validations (Attributes)
  validates :user_id,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end