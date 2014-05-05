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

	def composer
		proposal && users.find(proposal.composer_id)
	end

	def receiver
		proposal && users.find(proposal.receiver_id)
	end

	def composer_goods
		proposal && proposal.composer_goods
	end

	def receiver_goods
		proposal && proposal.receiver_goods
	end

	def goods
		proposal && proposal.goods
	end
end
