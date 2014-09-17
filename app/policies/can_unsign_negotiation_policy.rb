class CanUnsignNegotiationPolicy

  attr_accessor :negotiation

	def initialize(negotiation)
		self.negotiation=negotiation
	end
	
	def can_unsign?(user_id)
		return false unless negotiation.authorized? user_id
		return false unless @negotiation.negotiable?
		return false unless negotiation.signer == user_id
		true
	end
end
