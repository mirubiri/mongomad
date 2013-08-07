class Request
  include Mongoid::Document
  include Mongoid::Timestamps
#   include Denormalized
#   include ImageManagement::ImageHolder

  belongs_to :user

#   field :name, type: String
#   field :text, type: String

#   denormalize :image_fingerprint, from:'user.profile'
#   denormalize :name, from:'user'

  validates :user,
#     :name,
#     :text,
    presence: true

#   validates :text,
#     length: { minimum: 1, maximum: 160 }
end
