class User::Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include ImageManagement::ImageHolder

  embedded_in :user

  field :name,             type: String
  field :surname,          type: String
  field :nick,             type: String
  field :sex,              type: String
  field :country,          type: String
  field :delivery_address, type: String
  field :phone_number,     type: String
  field :website,          type: String
  field :birth_date,       type: Date

  validates :name,
    :surname,
    :nick,
    :sex,
    :country,
    :birth_date,
    presence: true
end
