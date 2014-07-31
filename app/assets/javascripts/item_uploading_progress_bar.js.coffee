$ ->
  $("body").on "fileuploadprogress", ".cloudinary-fileupload" , (e, data) ->
    $(".progress_bar").css "width", Math.round((data.loaded * 100.0) / data.total) + "%"
    return
