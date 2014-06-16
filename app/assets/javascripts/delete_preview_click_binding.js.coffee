$(document).ready ->
  # Borra la preview al pulsar el boton '-'
  $ ->
    $(".delete_preview").on "click", (event) ->
      deleteCoordinatesOnlyValues($(this))
      deleteMainImage()
      deletePreviewSelected($(this))
      deleteHiddenInputForPreview($(this))
      setNextPreviewAsMain($(this))
      return
