$(document).ready ->
  $(".cloudinary-fileupload").on "cloudinarydone" , (e, data) ->
    data = $(this).attr "data-cloudinary-field"
    data_lenght = data.toString().length
    select_number = data.toString().substring(data_lenght-2,data_lenght-1)
    imageSelectionFromCloudinaryInput(this,select_number)
    return
