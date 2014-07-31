@imageSelectionFromCloudinaryInput = (data, selector) ->

  $.cloudinary.config({ cloud_name: 'improcex', api_key: '679381134621623'})

  $(".preview").html $.cloudinary.image(data.result.public_id)


  # originalWidth = this.width
  # originalHeight = this.height
  # showedWidth = $("#pan").width()
  # showedHeight = $("#pan").height()
  # factorX = originalWidth/showedWidth
  # factorY = originalHeight/showedHeight



  # pan_image.css "width" , Math.round(rx * photoX) + "px"  width: $item-preview-big;
  # pan_image.css "width" , Math.round(rx * photoX) + "px"  height: $item-preview-big;
  # pan_image.css "width" , Math.round(rx * photoX) + "px"  max-width: $item-preview-big;
  # pan_image.css "width" , Math.round(rx * photoX) + "px"  max-height: $item-preview-big;

  # reloadProgressBar()
  # setPreviewImage(image)

  # deleteCoordinatesBlock(selector)
  # addCoordinates(selector)
  # addCropToSelector('#main_image',selector, factorX, factorY)
  # setCoordinatesIdasCloudinaryId(selector)

  # $("#preview" + selector).attr "src", image.src
  # $("#coordinates" + selector).attr "factorX", factorX
  # $("#coordinates" + selector).attr "factorY", factorY

  # setPreviewAsMain(selector)

  return
