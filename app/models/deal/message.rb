class Deal::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :deal

  field :user_nickname, type: String
  field :text,          type: String

  mount_uploader :image, UserImageUploader

  validates :user_nickname,
            :text,
            :image,
            presence: true
end
