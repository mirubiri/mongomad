class MessagePoster
	attr_accessor :conversable

	def initialize(conversable)
		self.conversable=conversable
	end

  def post_message(message)
    return false unless conversable.authorized? message.id
    conversable.messages << message
    true
  end
	
end
