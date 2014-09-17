module ImageHelper

  def static_image_tag(public_id, klass)
    cl_image_tag("static/#{public_id}", class:klass)
  end

  def big_image_tag(image,klass)
    base(h:300,w:300,klass:klass,image:image)
  end

  def medium_image_tag(image,klass)
    base(h:155,w:155,klass:klass,image:image)
  end

  def small_image_tag(image,klass)
    base(h:80,w:80,klass:klass,image:image)
  end  

  private
  
  def base(h:,w:,klass:,image:)
    cl_image_tag(image.id,
       transformation:[ 
        {x:image.x, y:image.y, width:image.w, height:image.h, crop:crop },
        {width:width, height:height, crop:fit, class:klass}
       ])
  end
end
