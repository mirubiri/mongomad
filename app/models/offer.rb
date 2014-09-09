class Offer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :false
  
  field :negotiation_id
  field :message

  def negotiable?
    !negotiating?
  end

  def negotiate
    negotiable=NegotiationStarter.new(self)
    negotiable.start
  end

  def negotiating?
    persisted? && negotiation_id?
  end
end
