class Alert
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, autosave:false

  field :text
  field :location, type: Array

  validates_presence_of :user, :location
  validates :text, length: { minimum: 1, maximum: 160 }
end
