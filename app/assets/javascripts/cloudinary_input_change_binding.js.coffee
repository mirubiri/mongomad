$ ->

  $("body").on "cloudinarydone" , (e, data) ->
    alert "cloudinary done"
    data = $(this).attr "data-cloudinary-field"
    data_lenght = data.toString().length
    select_number = data.toString().substring(data_lenght-2,data_lenght-1)
    imageSelectionFromCloudinaryInput(this,select_number)
    return
