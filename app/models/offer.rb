class Offer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :false
  
  field :negotiation_id
  field :message

  def negotiable?
    @policy ||= NegotiableOfferPolicy.new(self)
    @policy.negotiable?
  end

  def negotiate
    negotiable=NegotiationStarter.new(self)
    negotiable.start
  end

  def negotiating?
    not negotiable?
  end
end
