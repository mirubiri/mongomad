class NegotiationBox
  include Mongoid::Document
  embedded_in :user
  has_many :negotiations,autosave: true
end
