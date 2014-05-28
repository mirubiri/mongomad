class ProposalBuilder
	def initialize(proposal:Proposal.new)
		@proposal=proposal
	end

	def composer(user)
		@proposal.composer_id=user.id
		self
	end

	def receiver(user)
		@proposal.receiver_id=user.id
		self
	end

	def goods(goods)
		@proposal.goods = goods.map do |good|
			if good[:id] == 'cash'
				Cash.new(user_id:good[:user_id],amount:good[:amount])
			else
				Item.find(good[:id]).to_product
			end
		end
		self
	end

	def reset
		@proposal=Proposal.new
		true
	end

	def build
		@proposal
	end
end
