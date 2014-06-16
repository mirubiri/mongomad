@imageSelectionBeforeItemEdition = (input, selector) ->    
  
  image = new Image()
  image.src = input.attr "src"

  originalWidth = image.width
  originalHeight = image.height
  showedWidth = $("#pan").width()
  showedHeight = $("#pan").height()
  factorX = originalWidth/showedWidth
  factorY = originalHeight/showedHeight  

  setPreviewImage(image)
  addCropToSelector('#main_image',selector, factorX, factorY)
  
  $("#inputcontainer" + selector).find("img").attr "src", image.src 

  $("#coordinates" + selector).attr "factorX", factorX
  $("#coordinates" + selector).attr "factorY", factorY 

  return
