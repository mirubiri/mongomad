class Good
  include Mongoid::Document
  embedded_in :proposal
end
