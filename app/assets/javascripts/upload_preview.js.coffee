$ ->
  $(".cloudinary-fileupload").bind "cloudinarydone", (e, data) ->
    $(".preview").html $.cloudinary.image(data.result.public_id,
      format: data.result.format
      version: data.result.version
    )
    $(".progress_bar").width(0)
    $(".preview").children().attr "id","mainPreview"
    true
