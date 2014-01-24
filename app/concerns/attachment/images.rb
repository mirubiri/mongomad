module Attachment::Images
  extend ActiveSupport::Concern

  included do
    embeds_many :images, class_name: "Attachment::Image", as: :attachable

    validate :check_main_image_exist, :check_multiple_main_image
  end

  private
  def check_main_image_exist
    errors.add(:images, "There is no main image") unless images.where(main:true).exists?
  end

  def check_multiple_main_image
    errors.add(:images, "Cannot have more than one main image") if images.where(main:true).size > 1
  end

  public
  def main_image
    images.where(main:true).first
  end

  def set_main_image(image_id)
    image = images.where(id:image_id).first
    if image
      main_image.main = false
      image.main = true
      true
    else
      false
    end
  end
end
