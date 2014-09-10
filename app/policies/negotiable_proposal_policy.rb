class NegotiableProposalPolicy
  def initialize(proposal)
    @proposal=proposal
  end

  def negotiable?
    true
  end
end