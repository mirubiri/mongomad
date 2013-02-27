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
    self.save
  end

  def unpublish
    self.destroy
  end

  def alter_contents(request_params=[])
    self.text = request_params[:text]
    true
  end

  def self_update!
    reload if persisted?
    self.user_name = user.profile.nickname
    self.image_name = user.profile.image_name
    self
  end
end
