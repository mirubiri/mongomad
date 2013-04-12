class Negotiation::Conversation::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalized

  embedded_in :conversation, class_name: "Negotiation::Conversation"

  field :user_id,   type: Moped::BSON::ObjectId
  field :nick,      type: String
  field :text,      type: String
  field :image_url, type: String

  denormalize :nick, :image_url, from:'user.profile'

  validates :conversation,
    :user_id,
    :nick,
    :text,
    :image_url,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }

  def user
    conversation.negotiation.negotiators.find(user_id)
  end
end
