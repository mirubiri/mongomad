class Alert
  include Mongoid::Document

  belongs_to :user

  field :text
  field :location, type: Array
end
