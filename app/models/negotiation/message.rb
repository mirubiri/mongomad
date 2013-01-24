class Negotiation::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation

  field :user_name, type: String
  field :text,      type: String

  mount_uploader :image, UserImageUploader

  validates :negotiation,
            :user_name,
            :text,
            :image,
            presence: true
end
