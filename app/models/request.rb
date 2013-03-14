class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :user_name, type: String
  field :text,      type: String

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  validates :user,
    :user_name,
    :text,
    :image_name,
    presence: true

  def self.generate(request_params=[])
    raise "text is not valid" if (request_params[:text] == nil || request_params[:text] == '')
    request = Request.new(text: request_params[:text])
    request
  end

  def publish
    raise "the request is currently published" if persisted?
    save
  end

  def unpublish
    raise "the request is currently unpublished" unless persisted?
    destroy
  end

  def alter_contents(request_params=[])
    if request_params.has_key?(:text)
      raise "text is not valid" if (request_params[:text] == nil || request_params[:text] == '')
      self.text = request_params[:text]
    end
    persisted? ? save : self
  end

  def self_update!
    raise "user is not valid" if (user == nil  || user.persisted? == false)
    reload if persisted?
    self.user_name = user.profile.nickname
    self.image_name = user.profile.image_name
    persisted? ? save : self
  end
end
