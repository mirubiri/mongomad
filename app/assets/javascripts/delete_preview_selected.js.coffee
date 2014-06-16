@deletePreviewSelected = (element) ->
  preview_number = element.siblings(".add_image_container").find("img").attr "id"
  selector = preview_number.toString().substr(-1)
  element.siblings(".add_image_container").find("img").remove()
  element.siblings(".add_image_container").prepend '<img src="" id="preview'+selector+'">'
