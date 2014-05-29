class RequestBuilder
  def initialize(request=Request.new)
    @request = request
  end

  def text(text)
    @request.text = text
    self
  end

  def user(user)
    @request.user_id = user.id
    @request.user_sheet= user.sheet
    self
  end

  def reset
    @request=Request.new
  end

  def build
    @request
  end
end
