module ImageHelper

  def static_image_path(public_id)
    cl_image_path("static/#{public_id}")
  end

  def big_image_path(image)
    base(h:300,w:300,image:image)
  end

  def medium_image_path(image)
    base(h:155,w:155,image:image)
  end

  def small_image_path(image)
    base(h:80,w:80,image:image)
  end

  private
  def base(h:,w:,image:)
    cl_image_path(image.id,
      transformation:[
        { x:image.x, y:image.y, width:image.w, height:image.h, crop: :crop },
        { width:w, height:h, crop: :fit }
      ]) if image
  end
end
