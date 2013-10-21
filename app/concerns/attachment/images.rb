module Attachment
  module Images
    extend ActiveSupport::Concern

    included do
      embeds_many :images,class_name: "Attachment::Image",as: :attachable
    
      validate :check_main_image_exist, :check_multiple_main_image
    end

    def main_image
      images.where(main:true).first
    end

    def set_main_image(image_id)
      main_image.main = false
      images.find(image_id).main = true
      true
    end

    private
    def check_main_image_exist
      errors.add(:images, "There is no main image") unless images.count == 1
    end

    def check_multiple_main_image
      errors.add(:images, "Cannot have more than one main image") unless images.where(main:true).count == 1
    end
  end
end