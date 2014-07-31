$ ->
  $("body").on "cloudinarydone", ".cloudinary-fileupload" , (e, data) ->
    selector = $(this).attr "data-cloudinary-field"
    selector_lenght = selector.toString().length
    select_number = selector.toString().substring(selector_lenght-2,selector_lenght-1)
    imageSelectionFromCloudinaryInput(data,select_number)
    return
