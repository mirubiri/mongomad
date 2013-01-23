class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :user_nickname, type: String
  field :text,      type: String

  mount_uploader :image, UserImageUploader

  validates :user,
            :user_nickname,
            :text,
            :image,
            presence: true
end
