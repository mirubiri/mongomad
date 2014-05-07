module ApplicationHelper
  def unique_partial(partial_name)
    "application/unique_components/"+partial_name
  end

  def unique_layout(layout_name)
    "application/unique_components/"+layout_name+"_layout"
  end

  def shared_partial(partial_name)
    "application/shared_components/"+partial_name
  end

  def shared_layout(layout_name)
    "application/shared_components/"+layout_name+"_layout"
  end
end
