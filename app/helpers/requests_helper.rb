module RequestsHelper
  # Images
  def request_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 39, :height => 39, :crop => :fit)
  end

  # Modal
  def request_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :fit, :radius => :max)
  end
end
