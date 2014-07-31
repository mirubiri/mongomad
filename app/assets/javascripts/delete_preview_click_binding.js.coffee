$ ->
  $("body").on "click", ".delete_preview" , (e, data) ->
    deleteCoordinatesOnlyValues($(this))
    deleteMainImage()
    deletePreviewSelected($(this))
    deleteHiddenInputForPreview($(this))
    setNextPreviewAsMain($(this))
    return
