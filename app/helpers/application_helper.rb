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

  def static_image_tag(public_id, width=35, height=35)
    cl_image_tag("static/#{public_id}", :width => width, :height => height, :crop => :fill)
  end

  def user_image_tag(user, width=80, height=80)
    if user != nil && user.images.size != 0
      image = user.images.first
      cl_image_tag(image.id,
        :transformation => { :x => image.x, :y => image.y, :width => image.w, :height => image.h, :crop => :crop },
        :width => width, :height => heith, :crop => :fit)
    else
      static_image_tag('user_default',width,height)
    end
  end

  def item_main_image_tag(item, width=155, height=155)
    if item != nil
      image = item.images.where(main:true).first
      cl_image_tag(image.id,
        :transformation => { :x => image.x, :y => image.y, :width => image.w, :height => image.h, :crop => :crop },
        :width => width, :height => heith, :crop => :fit)
    end
  end

  def item_image_tag(item, index=0, width=155, height=155)
    if item != nil
      image = item.images[index]
      cl_image_tag(image.id,
        :transformation => { :x => image.x, :y => image.y, :width => image.w, :height => image.h, :crop => :crop },
        :width => width, :height => heith, :crop => :fit)
    end
  end
end
