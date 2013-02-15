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

  def self.generate(params=[])
    request = new(
      user: User.find(params[:user_id]),
      text: params[:text]
    )
    request.self_update
  end

  def publish
    save
  end

  def unpublish
    destroy
  end

  def self_update
    reload if persisted?
    self.user_name = user.profile.nickname
    self.image_name = user.profile.image_name
    self
  end
end
