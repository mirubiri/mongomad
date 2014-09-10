class NegotiableNegotiationPolicy
  def initialize(negotiation)
    @negotiation=negotiation
    @proposal_negotiable=negotiation.proposal.negotiable?
  end

  def one_user?
    @negotiation.user_ids.count == 1
  end

  def proposal_negotiable?
    @negotiation.proposal.negotiable?
  end

  def negotiable?
    return false if one_user?
    return false unless proposal_negotiable?
    true
  end

end