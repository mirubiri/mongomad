module ApplicationHelper

  def element(name,view:'default',data:nil)
    element="elements/#{name}/#{name}"
    view="elements/#{name}/views/#{view}"

    render partial: element,
      layout: view,
      object: data
  end

  def component(name,view:'default',data:nil)
    element="elements/components/#{name}/#{name}"
    view="elements/components/#{name}/views/#{view}"

    render partial: element,
      layout: view,
      object: data
  end

  def static_image_tag(public_id)
    cl_image_tag("static/#{public_id}")
  end

  def yield_content(content_key)
    view_flow.content.delete(content_key)
  end

  def object_main_image_tag(object,width,height)
    main_image = object.images.where(main:true).first
    cl_image_tag(main_image.id,
      :transformation => {
        :x => main_image.x,
        :y => main_image.y,
        :width => main_image.w,
        :height => main_image.h,
        :crop => :crop },
      :width => width,
      :height => height,
      :html_width => width,
      :html_height => height,
      :crop => :fit)
  end

  def active_tab?(*controller_names)
    active = false
    controller_names.each { |name| active ||= params[:controller] == name }
    active ? 'active_nav' : nil
  end
end
