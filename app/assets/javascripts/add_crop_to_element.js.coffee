@addCropToSelector = (id_selector,preview_image_selector) ->
  $(id_selector).Jcrop
    onSelect: (coords) ->
                showCoords coords,preview_image_selector
                showPreview coords,preview_image_selector
    onChange: (coords) ->
                showCoords coords,preview_image_selector
                showPreview coords,preview_image_selector
    bgColor: 'white',
    bgOpacity: 0.8,
    setSelect: [ 100, 100, 50, 50 ],
    aspectRatio: 1
