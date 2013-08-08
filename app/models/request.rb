class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :name
  field :text

  validates_presence_of :name,:text,:user
  validates :text, length: { minimum: 1, maximum: 160 }
end
