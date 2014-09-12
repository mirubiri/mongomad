class Offer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :false
  
  field :negotiation_id
  field :message

  def negotiable?
    negotiable_policy.negotiable?
  end

  def negotiate
    negotiable=NegotiationStarter.new(self)
    negotiable.start
  end

  def negotiating?
    negotiation_id?
  end

  private

  def negotiable_policy
    @negotiable_policy ||= NegotiableOfferPolicy.new(self)
  end
end
