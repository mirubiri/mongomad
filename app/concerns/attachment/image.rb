module Attachment
	class Image
		include Mongoid::Document

		embedded_in :attachable,polymorphic:true

		field :main, type: Boolean, default:false
	end
end