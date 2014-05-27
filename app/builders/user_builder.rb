class UserBuilder
	def initialize(user=User.new)
		@user=user
	end

	def nick(nick)
		@user.nick=nick
		self
	end

	def password(password)
		@user.password=password
		self
	end

	def first_name(first_name)
		@user.first_name=first_name
		self
	end

	def last_name(last_name)
		@user.last_name=last_name
		self
	end

	def gender(gender)
		@user.gender=gender
		self
	end

	def birth_date(birth_date)
		@user.birth_date=birth_date
		self
	end

	def location(location)
		@user.location=location
		self
	end

	def language(language)
		@user.language=language
		self
	end

	def email(email)
		@user.email=email
		self
	end

	def build
		@user
	end
end