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
    request = new(text: request_params[:text])
    request
  end

  def publish
    raise "the request is currently published" if self.persisted?
    self.save
  end

  def unpublish
    raise "the request is currently unpublished" unless self.persisted?
    self.destroy
  end

  def alter_contents(request_params=[])
    self.text = request_params[:text] if request_params[:text]
    persisted? ? save : self
  end

  def self_update!
    raise "user is not valid" if user == nil
    reload if persisted?
    self.user_name = user.profile.nickname
    self.image_name = user.profile.image_name
    persisted? ? save : self
  end
end
