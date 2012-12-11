class User::Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  embedded_in :user

  field :name,             type: String
  field :surname,          type: String
  field :nickname,         type: String
  field :sex,              type: String
  field :country,          type: String
  field :delivery_address, type: String
  field :phone_number,     type: String
  field :website,          type: String
  field :birth_date,       type: Date
  has_mongoid_attached_file :image

  validates :user,
            :name,
            :surname,
            :nickname,
            :sex,
            :country,
            :birth_date,
            :image,
            presence: true
end
