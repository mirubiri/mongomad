module ProposalManager
	extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  	def manage_proposal(method)
  		@managed_proposal=method
  	end
  end

  def managed_proposal
  	@managed_proposal
  end
end