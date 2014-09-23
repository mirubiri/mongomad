class AuthorizedNegotiationPolicy
	attr_accessor :negotiation
	def initialize(negotiation)
		self.negotiation=negotiation
	end

	def authorized?(user_id)
		return false if negotiation.abandoned?
		negotiation.participant? user_id
	end
end
