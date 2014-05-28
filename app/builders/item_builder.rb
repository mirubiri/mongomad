class ItemBuilder
	def initialize(item:Item.new)
		@item=item
	end

	def user(user)
		@item.user_sheet=user.sheet
		@item.user_id=user.id
		self
	end

	def name(name)
		@item.name=name
		self
	end

	def description(description)
		@item.description=description
		self
	end

	def images(images)
		@item.images = images.map do |image|
			Attachment::Image.new(
				x: image[:x],
				y: image[:y],
				w: image[:w],
				h: image[:h],
				main: image[:main] ) do |i|
					i.id=image[:id]
				end
		end
		self
	end

	def reset
		@item=Item.new
		true
	end

	def build
		@item
	end
end
