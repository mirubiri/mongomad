class User::Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include ImageManagement::ImageHolder

  embedded_in :user

  field :first_name,             type: String
  field :last_name,          type: String
  field :gender,              type: String
  field :birth_date,       type: Date
  field :language,    type: String

  validates :first_name,
    :last_name,
    :language,
    presence: true
end
