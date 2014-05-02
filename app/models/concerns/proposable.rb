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

			if state == :false
				include NonHistoricMethods
			  embeds_one :proposal, as: :proposal_container
			end
		end

		module HistoricMethods
			def proposal
				proposals.last
			end
		end

		module NonHistoricMethods
		end
	end
end
