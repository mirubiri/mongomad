$ ->
  $(".cloudinary-fileupload").bind "cloudinarydone", (e, data) ->
    $(".preview").html $.cloudinary.image(data.result.public_id,
      format: data.result.format
      version: data.result.version
    )
    $(".progress_bar").width(0)
    $(".preview").children().attr "id","mainPreview"
    $("#mainPreview").Jcrop
      onSelect: showCoords
      onChange: showCoords
      setSelect:   [ 200, 200, 40, 40 ]
      minSize: [ 200, 200 ]
      aspectRatio: 1
    #$(".image_public_id").val data.result.public_id
    true

showCoords = (c) ->
  $("#x1")
    .val c.x
    .attr "value",c.x
  $("#y1")
    .val c.y
    .attr "value",c.y
  $("#h")
    .val c.h
    .attr "value",c.h
  $("#w")
    .val c.w
    .attr "value",c.w
  return
