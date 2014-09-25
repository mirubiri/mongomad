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

  def empty_element(name, view: :default, data:nil, state:nil)
    element = "elements/#{name}/empty_#{name}"
    view = "elements/#{name}/views/#{view}"

    render partial: element,
      layout: view,
      locals:{ name.to_sym => data, state:state }
  end

  def empty_component(name, view: :default, data:nil, state:nil)
    component = "elements/components/#{name}/empty_#{name}"
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
end
