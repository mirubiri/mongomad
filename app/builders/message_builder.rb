class MessageBuilder

  def initialize()
    @message=Message.new
  end

  def user(user)
    @message.id=user.id
    self
  end

  def text(text)
    @message.text=text
    self
  end

  def build
    @message
  end

end
