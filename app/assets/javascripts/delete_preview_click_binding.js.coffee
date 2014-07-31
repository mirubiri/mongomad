$ ->

  $(".delete_preview").on "click", (event) ->
    deleteCoordinatesOnlyValues($(this))
    deleteMainImage()
    deletePreviewSelected($(this))
    deleteHiddenInputForPreview($(this))
    setNextPreviewAsMain($(this))
    return
