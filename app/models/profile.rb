class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :gender
  field :birth_date, type: Date
  field :language

  validates_presence_of :language
end
