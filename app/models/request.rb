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

  validates :text,
    length: { minimum: 1, maximum: 160 }

  def self.generate(request_params)
    Request.new(text:request_params[:text])
  end

  def publish
    raise "the request is currently published" if persisted?
    save
  end

  def unpublish
    raise "the request is currently unpublished" unless persisted?
    destroy
  end

  def alter_contents(request_params)
    if request_params.has_key?(:text)
      self.text = request_params[:text]
    end
    persisted? ? save : self
  end

  def self_update!
    reload if persisted?
    self.user_name = user.profile.nickname
    self.image_name = user.profile.image_name
    persisted? ? save : self
  end
end
