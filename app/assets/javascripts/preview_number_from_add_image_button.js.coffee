@previewNumberFromAddImageButton = (element) ->
  data = element.parent().siblings(".preview_selector").children().first().children().first().attr "data-cloudinary-field"
  data_lenght = data.toString().length
  select_number = data.toString().substring(data_lenght-2,data_lenght-1)
  return select_number
