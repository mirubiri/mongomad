@addCropToSelector = (id_selector,preview_image_selector,factorX,factorY) ->
  
  posX1 = $("#coordinates"+preview_image_selector).attr "cropX1"

  if posX1 > 0
    #alert("hay coordenadas")
    posX1 = $("#coordinates"+preview_image_selector).attr "cropX1"
    posY1 = $("#coordinates"+preview_image_selector).attr "cropY1"
    posX2 = $("#coordinates"+preview_image_selector).attr "cropX2"
    posY2 = $("#coordinates"+preview_image_selector).attr "cropY2"
  else
    #alert("no hay coordenadas")  
    posX1 = 50
    posY1 = 50
    posX2 = 150
    posY2 = 150

  $(id_selector).Jcrop
    onSelect: (coords) ->
                showPreview coords,preview_image_selector
    onChange: (coords) ->
                writeCoords coords, preview_image_selector
                showCoords coords,preview_image_selector,factorX,factorY
                showPreview coords,preview_image_selector
    bgColor: 'white',
    bgOpacity: 0.8,
    setSelect: [ posX1, posY1, posX2, posY2 ],
    aspectRatio: 1
