@deleteMainImage = ->
  element = $("#pan")
  element.children().remove()
  element.append("<img id='main_image' src>")
