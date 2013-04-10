class Negotiation::Conversation::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalized

  embedded_in :conversation, class_name: "Negotiation::Conversation"

  field :user_id,  type: Moped::BSON::ObjectId
  field :nickname, type: String
  field :text,     type: String

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  denormalize :nickname, :image_name, from:'user.profile'

  validates :conversation,
    :user_id,
    :nickname,
    :text,
    :image_name,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }

  def user
    @user ||= User.find(self.user_id)
  end

  def reload
    @user=nil
    super
  end
end
