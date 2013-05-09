class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalized
  include ImageManagement::ImageHolder

  belongs_to :user

  field :nick, type: String
  field :text, type: String

  denormalize :nick, :image_fingerprint, from:'user.profile'

  validates :user,
    :nick,
    :text,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }
end
