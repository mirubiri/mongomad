module ImageManagement::ImageHolder
  extend ActiveSupport::Concern

  included do

    field :image_url,         type: String
    field :image_fingerprint, type: String

    before_save :manager_increase_image_use, :if => :new_image?

    after_destroy :manager_destroy_image, :if => :image_stored?

    validates :image_fingerprint,
              :image_url,
              presence:true
  end

  def image
    image_url
  end

  def image=(file)
    @image_manager ||= ImageManagement::ImageManager.new(file:file)
    manager_store_image
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

  def new_image?
    @image_manager.present?
  end

  def image_stored?
    image_url.present? && image_fingerprint.present?
  end

  def manager_store_image
    manager_destroy_image if image_stored?
    image_manager.store &&
    write_attribute(:image_url,image_manager.image[:url]) &&
    write_attribute(:image_fingerprint,image_manager.image[:fingerprint])
  end

  def manager_increase_image_use
    @image_manager.increase_image_use
    @image_manager=nil
  end
end