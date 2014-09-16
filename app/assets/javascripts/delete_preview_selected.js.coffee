@deletePreviewSelected = (element) ->
  preview_number = element.siblings(".cropped-image").find("img").attr "id"
  selector = preview_number.toString().substr(-1)
  element.siblings(".cropped-image").find("img").remove()
  element.siblings(".cropped-image").prepend '<img src="" id="preview'+selector+'">'
