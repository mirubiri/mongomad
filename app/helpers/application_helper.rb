module ApplicationHelper

  def yield_content(content_key)
    view_flow.content.delete(content_key)
  end

  def element(name, view: :default, data:nil, state:nil)
    element = "elements/#{name}/#{name}"
    view = "elements/#{name}/views/#{view}"

    render partial: element,
      layout: view,
      locals:{ name.to_sym => data, state:state }
  end

  def component(name, view: :default, data:nil, state:nil)
    component = "elements/components/#{name}/#{name}"
    view = "elements/components/#{name}/views/#{view}"

    render partial: component,
      layout: view,
      locals:{ name.to_sym => data, state:state }
  end

  def my_page?
    current_user == visited_user
  end

  def active_tab?(*controller_names)
    active = false
    controller_names.each { |name| active ||= params[:controller] == name }
    active ? 'active_nav' : nil
  end

  def static_image_tag(public_id, css_class)
    cl_image_tag("static/#{public_id}", :class => css_class )
  end

  def user_image_tag(user, css_class, width=80, height=80)
    if user != nil && user.images.size != 0
      image = user.images.first
      cl_image_tag(image.id,
        :transformation => { :x => image.x, :y => image.y, :width => image.w, :height => image.h, :crop => :crop },
        :width => width, :height => height, :crop => :fit, :class => css_class )
    else
      static_image_tag('user_default', css_class)
    end
  end

  def item_main_image_tag(item, css_class, width=155, height=155)
    images = item.images.where(main:true)
    if item != nil && images.size != 0
      image = images.first
      cl_image_tag(image.id,
        :transformation => { :x => image.x, :y => image.y, :width => image.w, :height => image.h, :crop => :crop },
        :width => width, :height => height, :crop => :fit, :class => css_class )
    end
  end

  def item_image_tag(item, index=0, css_class, width=155, height=155)
    if item != nil && item.images.size > index
      image = item.images[index]
      cl_image_tag(image.id,
        :transformation => { :x => image.x, :y => image.y, :width => image.w, :height => image.h, :crop => :crop },
        :width => width, :height => height, :crop => :fit, :class => css_class )
    end
  end
end
