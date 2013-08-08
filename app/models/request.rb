class Request
  include Mongoid::Document
  include Mongoid::Timestamps
#   include Denormalized
#   include ImageManagement::ImageHolder

  belongs_to :user

  field :name
  field :text

#   denormalize :image_fingerprint, from:'user.profile'
#   denormalize :name, from:'user'

  validates_presence_of :name,:text,:user

  validates :text, length: { minimum: 1, maximum: 160 }
end
