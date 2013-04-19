class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalized

  belongs_to :user

  field :nick,      type: String
  field :text,      type: String
  field :image_url, type: String

  denormalize :nick, :image_url, from:'user.profile'

  validates :user,
    :nick,
    :text,
    :image_url,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }
end
