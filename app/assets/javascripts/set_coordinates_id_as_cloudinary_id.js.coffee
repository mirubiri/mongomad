@setCoordinatesIdasCloudinaryId = (selector) ->
  inputValue = $('input[name=image'+selector+']').attr "value"
  idChar = inputValue.toString()
  positionBar = idChar.lastIndexOf("/");
  positionDot = idChar.indexOf(".");
  publicId = idChar.slice(positionBar+1,positionDot)
  $('input[id=id_preview'+selector+']').attr "value",publicId
  $('input[name=image'+selector+']').remove()
