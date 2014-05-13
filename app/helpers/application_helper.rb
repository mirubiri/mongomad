module ApplicationHelper
  def shared_partial(partial_name)
    "application/shared_components/#{partial_name}"
  end

  def shared_layout(layout_name)
    "application/shared_components/#{layout_name}_layout"
  end

  def unique_partial(partial_name)
    "application/unique_components/#{partial_name}"
  end

  def unique_layout(layout_name)
    "application/unique_components/#{layout_name}_layout"
  end

  def rounded_image_tag(public_id, width, height)
    cl_image_tag(public_id,
      :width => 200, :height => 200,
      :html_width => width, :html_height => height,
      :crop => :fit, :radius => :max)
  end

  def squared_image_tag(public_id, width, height)
    cl_image_tag(public_id,
      :width => 200, :height => 200,
      :html_width => width, :html_height => height,
      :crop => :fit, :radius => 20)
  end

  def static_image_tag(public_id, width, height)
    cl_image_tag(public_id,
      :width => width, :height => height,
      :html_width => width, :html_height => height,
      :crop => :fit)
  end
end
