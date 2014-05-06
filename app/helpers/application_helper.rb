module ApplicationHelper
  def unique_partial(partial_name)
    "application/unique_components/#{partial_name}"
  end

  def unique_layout(layout_name)
    "application/unique_components/layouts/#{layout_name}"
  end

  def shared_partial(partial_name)
    "application/shared_components/#{partial_name}"
  end

  def shared_layout(layout_name)
    "application/unique_components/layouts/#{layout_name}"
  end
end
