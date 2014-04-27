module Proposable
	extend ActiveSupport::Concern

	included do
		include Ownership::Dual
		include Ownership::Dual::Session
		embeds_one :proposal, as: :proposal_container
	end

	module ClassMethods
		def proposal_historic(state)
			embeds_many :previous_proposals, class_name: "Proposal", as: :proposal_container if state == :on
		end
	end
end