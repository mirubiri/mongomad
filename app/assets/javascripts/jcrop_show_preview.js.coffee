@showPreview = (coords, selector) ->
  maxX = $('#inputcontainer1').width()
  maxY = $('#inputcontainer1').height()
  rx = maxX / coords.w
  ry = maxY / coords.h
  rx = (if (rx is 0) then 1 else rx)
  ry = (if (ry is 0) then 1 else ry)
  photoX = $("#pan img").width()
  photoY = $("#pan img").height()
  $("#preview" + selector).css "width" , Math.round(rx * photoX) + "px"
  $("#preview" + selector).css "height" , Math.round(ry * photoY) + "px"
  $("#preview" + selector).css "marginLeft" , "-" + Math.round(rx * coords.x) + "px"
  $("#preview" + selector).css "marginTop" , "-" + Math.round(ry * coords.y) + "px"
  return
