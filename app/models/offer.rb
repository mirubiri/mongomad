class Offer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :false
  
  field :negotiation_id
  field :message

  def negotiable?
    persisted?
  end
end
