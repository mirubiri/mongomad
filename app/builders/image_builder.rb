class ImageBuilder
	def initialize(image=Attachment::Image.new)
		@image=image
	end

	def x(point_x)
		@image.x=point_x
		self
	end

	def y(point_y)
		@image.y=point_y
		self
	end

	def h(height)
		@image.h=height
		self
	end

	def w(width)
		@image.w=width
		self
	end

	def main(main)
		@image.main=main
		self
	end

	def id(image_id)
		@image.id=image_id
		self
	end

	def reset
		@image=Attachment::Image.new
		true
	end

	def build
		@image
	end

end
