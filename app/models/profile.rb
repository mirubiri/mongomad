class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  embeds_one :photo,class_name:"Image",as: :polymorphic_image

  field :name, type: String
  field :surname, type: String
  field :nickname, type: String
  field :password, type: String
  field :sex, type: String
  field :country, type: String
  field :email, type: String
  field :delivery_address, type: String
  field :phone_number, type: String
  field :website, type: String
  field :birth_date, type: Date

  validates :user,
            :name,
            :surname,
            :nickname,
            :sex,
            :country,
            :birth_date,
            :website,
            presence: true
end