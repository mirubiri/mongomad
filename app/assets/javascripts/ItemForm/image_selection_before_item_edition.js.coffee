@imageSelectionBeforeItemEdition = (input, selector) ->    
  
  alert("se lanza la mierda esta")

  image = new Image()
  image.src = input.attr "src"

  originalWidth = image.width
  originalHeight = image.height
  showedWidth = $("#pan").width()
  showedHeight = $("#pan").height()
  factorX = originalWidth/showedWidth
  factorY = originalHeight/showedHeight 

  x1 = $("#coordinates" + selector).attr "cropX1"
  $("#coordinates" + selector).attr "cropX1",(x1/factorX)

  y1 = $("#coordinates" + selector).attr "cropY1"
  $("#coordinates" + selector).attr "cropY1",(y1/factorY)

  x2 = $("#coordinates" + selector).attr "cropX2"
  $("#coordinates" + selector).attr "cropX2",(x2/factorX)
  
  y2 = $("#coordinates" + selector).attr "cropY2"   
  $("#coordinates" + selector).attr "cropY2",(y2/factorY)

  setPreviewImage(image)
  addCropToSelector('#main_image',selector, factorX, factorY)
  
  $("#inputcontainer" + selector).find("img").attr "src", image.src 

  $("#coordinates" + selector).attr "factorX", factorX
  $("#coordinates" + selector).attr "factorY", factorY

  return
