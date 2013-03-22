class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongomad::Denormalize

  belongs_to :user

  field :text, type: String
  field :nickname, type: String
  field :image_name, type: String
  
  denormalize :nickname,:image_name, from:'user.profile'

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  validates :user,
    :nickname,
    :text,
    :image_name,
    presence: true

  validates :text,
    length: { minimum: 1, maximum: 160 }
end
