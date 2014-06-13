@addCoordinates = (selector) ->
  if $("#id_preview"+selector).length < 1
    str = '<div id="coordinates'+selector+'"><input id="id_preview'+selector+'" name="item[images]['+selector+'][id]" type="hidden" value="nil"><input id="main_preview'+selector+'" name="item[images]['+selector+'][main]" type="hidden" value="true"><input id="x_preview'+selector+'" name="item[images]['+selector+'][x]" type="hidden" value="0"><input id="y_preview'+selector+'" name="item[images]['+selector+'][y]" type="hidden" value="0"><input id="h_preview'+selector+'" name="item[images]['+selector+'][h]" type="hidden" value="0"><input id="w_preview'+selector+'" name="item[images]['+selector+'][w]" type="hidden" value="0"></div>'
    html = $.parseHTML str
    $("#output").append html
