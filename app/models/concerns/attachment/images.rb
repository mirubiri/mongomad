module Attachment::Images
  extend ActiveSupport::Concern

  included do
    embeds_many :images, class_name: "Attachment::Image", as: :attachable
  end

  def main_image
    images.where(main:true).first
  end
end
