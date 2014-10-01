@deleteHiddenInputForPreview = (element) ->
  preview_number = element.siblings(".cropped-image").attr "id"
  selector = preview_number.toString().substr(-1)
  $("input:hidden[name='item[image"+selector+"]']").remove()
