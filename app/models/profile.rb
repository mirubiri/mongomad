class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  embedded_in :user

  field :first_name
  field :last_name
  field :gender
  field :language
  field :birth_date, type: Date
  field :location,   type: Array

  validates_presence_of :first_name, :last_name, :language, :location
end
