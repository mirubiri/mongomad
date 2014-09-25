module ApplicationHelper

  def yield_content(content_key)
    view_flow.content.delete(content_key)
  end

  def element(name, view: :default, data:NullObject.new, state:nil)
    base_element(name,view:view,data:data,state:state,
      route:"elements/")
  end

  def component(name, view: :default, data:NullObject.new, state:nil)
    base_element(name,view:view,data:data,state:state,
      route:"elements/components/")
  end

  def my_page?
    current_user == visited_user
  end

  def active_tab?(*controller_names)
    active = false
    controller_names.each { |name| active ||= params[:controller] == name }
    active ? 'active-nav' : nil
  end

  private

  def base_element(name, view:,data:,state:,route:)
    element = "#{route}/#{name}/#{name}"
    view = "#{route}/#{name}/views/#{view}"

    render partial: element,
    layout: view,
    locals:{ name.to_sym=>data,state:state }
  end
end
