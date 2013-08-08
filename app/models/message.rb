class Message
  include Mongoid::Document
  include Mongoid::Timestamps
#   include Denormalized
#   include ImageManagement::ImageHolder

  embedded_in :polymorphic_message, polymorphic: true
#   embedded_in :conversation, class_name: 'Negotiation::Conversation'

#   field :user_id, type: Moped::BSON::ObjectId
#   field :name,    type: String
#   field :text,    type: String

#   denormalize :image_fingerprint, from:'user.profile'
#   denormalize :name, from:'user'
#   validates :user_id,
#     :name,
#     :text,
#     presence: true

#   validates :text,
#     length: { minimum: 1, maximum: 160 }

#   def user
#     conversation.negotiation.negotiators.find(user_id)
#   end
end
