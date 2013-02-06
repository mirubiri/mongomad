class Deal::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :deal

  field :user_name, type: String
  field :text,      type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  validates :deal,
            :user_name,
            :text,
            :image,
            presence: true
end
