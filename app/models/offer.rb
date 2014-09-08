class Offer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :false
  
  field :message
end
