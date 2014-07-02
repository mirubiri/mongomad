$(document).ready ->

  # Al pinchar en una de las previews, reemplaza la imagen principal por esta
  $ ->
    $(".add_image_container").on "click", "img", (event, data) ->

      replaceMainWidthPreview($(this))
      preview_selected = previewNumberFromAddImageButton($(this))

      factorX = $("#coordinates" + preview_selected).attr "factorX"
      factorY = $("#coordinates" + preview_selected).attr "factorY"

      imageValue = $(this).attr "src"

      if imageValue != ""
        setPreviewAsMain(preview_selected)
      else
        setNextPreviewAsMain

      $("#coordinates" + preview_selected).attr "factorX", factorX
      $("#coordinates" + preview_selected).attr "factorY", factorY

      imageSelectionAfterPreviewClick($(this),preview_selected)      

      return
