module ProposalManager
	include ActiveSupport::Concern

	include do
		cattr_accessor :_proposal_method
	end

	module ClassMethods
		def manage_proposal_in(method)
			self._proposal_method=method.to_sym
		end
	end
end