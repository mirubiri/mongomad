class OfferBuilder
	def initialize(offer:Offer.new,proposal_builder:ProposalBuilder.new)
		@offer=offer
		@proposal_builder=proposal_builder
	end

	def composer(user)
		@offer.user_ids<<user.id
		@offer.user_sheets<<user.sheet
		@proposal_builder.composer user
		self
	end

	def receiver(user)
		@offer.user_ids<<user.id
		@offer.user_sheets<<user.sheet
		@proposal_builder.receiver user
		self
	end

	def goods(goods)
		@proposal_builder.goods goods
		self
	end

	def message(message)
		@offer.message = message
		self
	end

	def build
		@offer.proposal=@proposal_builder.build
		@offer
	end
end
