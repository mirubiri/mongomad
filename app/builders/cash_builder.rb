class CashBuilder
	def initialize(cash=Cash.new)
		@cash=cash
	end

	def user(user)
		@cash.user_id=user.id
		self
	end

	def amount(string)
		@cash.amount=string
		self
	end

	def build
		@cash
	end
end