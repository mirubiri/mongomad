class NegotiationProposer
	attr_accessor :negotiation

	def initialize(negotiation)
		self.negotiation=negotiation
	end

  def propose(proposal)
    return false unless
      negotiation.negotiable? &&
      negotiation.participates?(proposal.composer_id) &&
      negotiation.participates?(proposal.receiver_id)
  
    negotiation.proposals<<proposal
    negotiation.reset_course
  end
end
