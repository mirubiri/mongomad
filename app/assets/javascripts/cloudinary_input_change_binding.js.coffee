$(document).ready ->
  $(".cloudinary-fileupload").on "change", ->
      select_number = $(this)
                        .attr "data-cloudinary-field"
                        .toString()
                        .substr(-1)
      imageSelectionFromCloudinaryInput(this,select_number)
      return
