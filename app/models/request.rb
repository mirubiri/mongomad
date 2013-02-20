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
    :image,
    presence: true

  attr_protected :user_name

  def self.generate(request_params=[])
    request = new(
      user: User.find(request_params[:user_id]),
      text: request_params[:text]
    )
    request.self_update
  end

  def publish
    save
  end

  def unpublish
    destroy
  end

  def modify(request_params=[])
    update_attributes(request_params)
  end

  def self_update
    reload if persisted?
    self.user_name = user.profile.nickname
    self.image_name = user.profile.image_name
    self
  end
end
