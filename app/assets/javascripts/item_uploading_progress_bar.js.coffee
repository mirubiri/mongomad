$ ->
  $("body").on "fileuploadprogress", ".cloudinary-fileupload" , (e, data) ->
    $(".progress-bar").css "width", Math.round((data.loaded * 100.0) / data.total) + "%"
    return
