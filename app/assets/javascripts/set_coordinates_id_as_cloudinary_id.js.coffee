@setCoordinatesIdasCloudinaryId = (selector) ->
  inputValue = $("input[name='item[image"+selector+"]']").attr "value"
  idChar = inputValue.toString()
  positionBar = idChar.lastIndexOf("/");
  positionDot = idChar.indexOf(".");
  publicId = idChar.slice(positionBar+1,positionDot)
  $('input[id=id_preview'+selector+']').attr "value",publicId
