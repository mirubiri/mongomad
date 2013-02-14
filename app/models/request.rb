class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :user_name, type: String
  field :text,      type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  validates :user,
    :user_name,
    :text,
    :image,
    presence: true
end
