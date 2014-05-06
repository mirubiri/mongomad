class ItemBuilder
	attr_accessor :user,:name,:description,:main_image,:images
	def initialize
		self.images=[]
	end

	def create
		return false unless user.present? && name.present? && description.present? && main_image.present?
		item=Item.new
		item.name=name
		item.description=description
		item.main_image=main_image
		item.images=images
		item.user_id=user.id
		item
	end
end