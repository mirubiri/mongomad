class OfferOutbox
  include Mongoid::Document
  embedded_in :user
  has_many :offers,autosave: true
end
