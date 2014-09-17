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
    active ? 'active-nav' : nil
  end

  

  # def item_image_tag(item, index=0, css_class, width=155, height=155)
  #   if item != nil && item.images.size > index
  #     image = item.images[index]
  #     cl_image_tag(image.id,
  #       :transformation => { :x => image.x, :y => image.y, :width => image.w, :height => image.h, :crop => :crop },
  #       :width => width, :height => height, :crop => :fit, :class => css_class )
  #   end
  # end
end
