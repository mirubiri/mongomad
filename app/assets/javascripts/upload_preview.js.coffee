# Evento antes de subir con cloudinary
# $(document).ready ->
#   $(".cloudinary-fileupload").bind "fileuploadadd", (e, data) ->
#     alert(data.files[0])
#     return
#   return


$(document).ready ->
  $(".cloudinary-fileupload").bind "cloudinarydone", (e, data) ->
    $(".preview").find('img')
      .attr "src",$.cloudinary.image(data.result.public_id,
        format: data.result.format
        version: data.result.version
      ).attr "src"
      .draggable()
    $(".progress_bar").width(0)
    preview_number = $(this).attr "data-cloudinary-field"
    draggandcrop("#pan img", preview_number)
    true
  return
