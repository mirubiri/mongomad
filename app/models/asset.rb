class Asset
  include Mongoid::Document
  embedded_in :proposal
end
