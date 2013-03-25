class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalized

  belongs_to :user

  field :nickname,   type: String
  field :text,       type: String

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  denormalize :nickname, :image_name, from:'user.profile'

  validates :user,
    :nickname,
    :text,
    :image_name,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }
end
