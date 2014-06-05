module ApplicationHelper
  def single_content_for(name, content = nil, &block)
    @view_flow.set(name, ActiveSupport::SafeBuffer.new)
    content_for(name, content, &block)
  end

  def shared_partial(partial_name)
    "application/shared_components/#{partial_name}"
  end

  def shared_layout(layout_name)
    "application/shared_components/layouts/#{layout_name}_layout"
  end

  def unique_partial(partial_name)
    "application/unique_components/#{partial_name}"
  end

  def unique_layout(layout_name)
    "application/unique_components/layouts/#{layout_name}_layout"
  end

  def static_image_tag(public_id)
    cl_image_tag("static/#{public_id}")
  end

  def object_main_image_tag(object, width, height)
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
