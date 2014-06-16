@setPreviewImage = (image) ->
  $(".preview").find('img')
    .removeAttr "src"

  $(".preview").find('img')
    .attr "src", image.src
    .attr "id","main_image"
