module ImageManagement::ImageHolder
  extend ActiveSupport::Concern

  included do

    field :image_url, type: String
    field :image_fingerprint, type: String

    before_validation :manager_store_image, :unless => :image_stored?

    after_destroy :manager_destroy_image, :if => :image_stored?

    validates :image_fingerprint,
              :image_url,
              presence:true
  end

  def image
    image_url
  end

  def image=(file)
    @image_manager ||= ImageManagement::ImageManager.new(file:File.open(file))
  end

  def image_fingerprint=(fingerprint)
    @image_manager ||= ImageManagement::ImageManager.new(fingerprint:fingerprint)
  end

  private
  attr_reader :image_manager

  def manager_destroy_image
    manager=ImageManagement::ImageManager.new(fingerprint:image_fingerprint)
    manager.destroy
  end

  def image_stored?
    image_url.present? && image_fingerprint.present? && @image_manager.nil?
  end

  def manager_store_image
    manager_destroy_image if image_url.present && image_fingerprint.present?

    image_manager.try(:store) &&
    write_attribute(:image_url,image_manager.image[:url]) &&
    write_attribute(:image_fingerprint,image_manager.image[:fingerprint])
    @image_manager=nil
  end
end