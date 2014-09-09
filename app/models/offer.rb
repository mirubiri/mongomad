class Offer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :false
  
  field :negotiation_id
  field :message

  def negotiable?
    persisted? && !negotiation_id?
  end

  def negotiate
    negotiable=NegotiationStarter.new(self)
    negotiable.start
  end
end
