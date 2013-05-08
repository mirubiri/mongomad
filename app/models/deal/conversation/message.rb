class Deal::Conversation::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include ImageManagement::ImageHolder
  include Denormalized

  embedded_in :conversation, class_name: 'Deal::Conversation'

  field :user_id, type: Moped::BSON::ObjectId
  field :nick,    type: String
  field :text,    type: String

  denormalize :nick, :image_fingerprint, from:'user.profile'

  validates :user_id,
    :nick,
    :text,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }

  def user
    conversation.deal.signers.find(user_id)
  end
end
