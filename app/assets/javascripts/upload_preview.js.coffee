$ ->
  $(".cloudinary-fileupload").bind "cloudinarydone", (e, data) ->
    $(".preview").find('img')
      .attr "src",$.cloudinary.image(data.result.public_id,
        format: data.result.format
        version: data.result.version
      ).attr "src"
      .draggable()
    $(".progress_bar").width(0)
    $(".preview").children().attr "id","mainPreview"
    true
