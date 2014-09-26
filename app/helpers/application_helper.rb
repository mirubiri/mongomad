module ApplicationHelper

  def yield_content(content_key)
    view_flow.content.delete(content_key)
  end

  def component(name, view: :default,data:NullObject.new,state:nil)
    component = "components/#{name}/#{name}"
    view = "components/#{name}/views/#{view}"

    render partial: component,
    layout: view,
    locals:{ name.to_sym=>data,state:state }
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
