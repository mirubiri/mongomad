class DealBox
  include Mongoid::Document
  embedded_in :user
  has_many :deals,autosave: true
end
