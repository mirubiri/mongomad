module Proposable
	extend ActiveSupport::Concern

	included do
		include Ownership
		ownership :dual
	end

	module ClassMethods
		def proposal_historic(state)
			if state == :true		
			  include HistoricMethods	
				embeds_many :proposals, as: :proposal_container
			end

			embeds_one :proposal, as: :proposal_container if state == :false
		end

		module HistoricMethods
			def proposal
				proposals.last
			end
		end
	end
end
