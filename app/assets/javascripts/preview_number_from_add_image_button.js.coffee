@previewNumberFromAddImageButton = (element) ->
  preview_number = element.parent().siblings(".preview_selector").children().first().children().first().attr "data-cloudinary-field"
  selector = preview_number.toString().substr(-1)
  return selector
