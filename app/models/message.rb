class Message
  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embedded_in :polymorphic_message, polymorphic: true

  #Attributes
  field :sender_id, type: Moped::BSON::ObjectId
  field :sender_full_name, type: String
  field :text, type: String

  #Validations (Attributes)
  validates :sender_id,
            :sender_full_name,
            :text,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end