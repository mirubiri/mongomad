@addCropToSelector = (id_selector,preview_image_selector,factorX,factorY) ->
  $(id_selector).Jcrop
    onSelect: (coords) ->
                showCoords coords,preview_image_selector,factorX,factorY
                showPreview coords,preview_image_selector
    onChange: (coords) ->
                showCoords coords,preview_image_selector,factorX,factorY
                showPreview coords,preview_image_selector
    bgColor: 'white',
    bgOpacity: 0.8,
    setSelect: [ 150, 150, 50, 50 ],
    aspectRatio: 1
