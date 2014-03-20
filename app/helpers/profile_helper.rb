module ProfileHelper
  def profile_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 122, :height => 122, :crop => :fit)
  end

  def comment_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :fit, :radius => :max)
  end
end
