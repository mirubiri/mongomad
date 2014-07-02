class CashBuilder
	def initialize(cash=Cash.new)
		@cash=cash
		cash.id='cash'
	end

	def user(user)
		@cash.user_id=user.id
		self
	end

	def amount(string)
		@cash.amount=string
		self
	end

	def reset
		@cash=Cash.new
		true
	end

	def build
		@cash
	end
end