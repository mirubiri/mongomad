@deleteCoordinatesOnlyValues = (element) ->
  preview_number = element.siblings(".add_image_container").attr "id"
  selector = preview_number.toString().substr(-1)
  $('#coordinates'+selector+'').find('#id_preview'+selector+'').siblings().remove()
  $('#coordinates'+selector+'').find('#id_preview'+selector+'').attr "value","nil"
