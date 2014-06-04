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
    addCoordinatesRegistration(preview_number)
    draggandcrop("#pan img", preview_number)
    true
  return


@addCoordinatesRegistration = (preview_number) ->
  if preview_number == "image1"
    $('.name1').parent('div').hide
      zoomIn: $("#zoomin")
      zoomOut: $("#zoomout")      
      out_x1: $("#x1_preview1")
      out_y1: $("#y1_preview1")
      out_x2: $("#x2")
      out_y2: $("#y2")
      debug: false
  if preview_number == "image2"
    $(selector).panZoom
      zoomIn: $("#zoomin")
      zoomOut: $("#zoomout")      
      out_x1: $("#x1_preview2")
      out_y1: $("#y1_preview2")
      out_x2: $("#x2")
      out_y2: $("#y2")
      debug: false
  if preview_number == "image3"
    $(selector).panZoom
      zoomIn: $("#zoomin")
      zoomOut: $("#zoomout")      
      out_x1: $("#x1_preview3")
      out_y1: $("#y1_preview3")
      out_x2: $("#x2")
      out_y2: $("#y2")
      debug: false  
