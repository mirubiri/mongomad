class AuthorizedNegotiationPolicy
	attr_accessor :negotiation
	def initialize(negotiation)
		self.negotiation=negotiation
	end

	def authorized?(user_id)
		negotiation.user_ids.include? user_id
	end
end