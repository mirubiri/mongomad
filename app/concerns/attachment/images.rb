module Attachment
  module Images
    extend ActiveSupport::Concern

    included do
      embeds_many :images,class_name: "Attachment::Image",as: :attachable
    
      validate :check_main_image_exist
    end

    def main_image
    end

    def set_main_image(image_id)
    end

    private
    def check_main_image_exist
      errors.add(:images, "There is no main image") unless images
    end

    # def check_multiple_main_image
    #   # errors.add(:images, "Cannot have more than one main image") unless if images.size == 1
    # end
  end
end