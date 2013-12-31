class Alert
  include Mongoid::Document

  belongs_to :user

  field :text
  field :location, type: Array

  validates_presence_of :user, :text, :location
  validates :text, length: { minimum: 1, maximum: 160 }
end
