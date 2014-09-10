class NegotiableNegotiationPolicy
  def initialize(negotiation)
    @negotiation=negotiation
    @proposal_negotiable=negotiation.proposal.negotiable?
  end

  def _one_user?
    @negotiation.user_ids.count == 1
  end

  def _proposal_negotiable?
    @negotiation.proposal.negotiable?
  end

  def negotiable?
    return false if _one_user?
    return false unless _proposal_negotiable?
    true
  end

end