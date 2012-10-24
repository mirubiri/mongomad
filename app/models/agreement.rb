class Agreement
  include Mongoid::Document
  embedded_in :deal
end
