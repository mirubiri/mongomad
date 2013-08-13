class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :gender
  field :language
  field :birth_date, type: Date

  validates_presence_of :language
end
