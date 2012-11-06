class Profile
  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embedded_in :user

  #Attributes
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

  #Validations (Attributes)
  validates :name,
            :surname,
            :nickname,
            :password,
            :sex,
            :country,
            :email,
            :delivery_address,
            :phone_number,
            :website,
            :birth_date,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)
end