class NegotiableNegotiationPolicy
  attr_accessor :negotiation

  def initialize(negotiation)
    self.negotiation=negotiation
  end
  
  def negotiable?
    return false if negotiation.abandoned?
    return false unless proposal_negotiable?
    true
  end


  private

  def one_user?
    @negotiation.user_ids.count == 1
  end

  def proposal_negotiable?
    @negotiation.proposal.negotiable?
  end
end