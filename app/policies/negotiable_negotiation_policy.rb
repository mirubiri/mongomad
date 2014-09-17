class NegotiableNegotiationPolicy
  attr_accessor :negotiation

  def initialize(negotiation)
    self.negotiation=negotiation
  end
  
  def negotiable?
    proposal_negotiable?
  end

  private

  def proposal_negotiable?
    @proposal_negotiable ||= negotiation.proposal.negotiable?
  end
end
