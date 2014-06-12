$(document).ready ->

  # Al pinchar en una de las previews, reemplaza la imagen principal por esta
  $ ->
    $(".add_image_container").on "click", "img", (event, data) ->

      replaceMainWidthPreview($(this))
      preview_selected = previewNumberFromAddImageButton($(this))
      
      factorX = $("#coordinates" + preview_selected).attr "factorX"
      factorY = $("#coordinates" + preview_selected).attr "factorY"

      deleteCoordinatesOfPreviewFromImage($(this))
      addCoordinates(preview_selected)

      $("#coordinates" + preview_selected).attr "factorX", factorX
      $("#coordinates" + preview_selected).attr "factorY", factorY

      addCropToSelector('#main_image',preview_selected,factorX,factorY)
      imageSelection($(this),preview_selected)      
      setPreviewAsMain(preview_selected)
      return
