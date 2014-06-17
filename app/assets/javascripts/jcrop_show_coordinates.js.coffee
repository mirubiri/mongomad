@showCoords = (c, selector, factorX, factorY) ->
  if $("#coordinates" + selector).attr "cropX1"
    x1 = $("#coordinates" + selector).attr "cropX1"
    y1 = $("#coordinates" + selector).attr "cropY1"
    x2 = $("#coordinates" + selector).attr "cropX2"
    y2 = $("#coordinates" + selector).attr "cropY2"

    $("#x_preview" + selector).val(c.x * factorX)
    $("#y_preview" + selector).val(c.y * factorY)
    $("#h_preview" + selector).val(c.h * factorY)
    $("#w_preview" + selector).val(c.w * factorX)
  else
    $("#x_preview" + selector).val(c.x * factorX)
    $("#y_preview" + selector).val(c.y * factorY)
    $("#h_preview" + selector).val(c.h * factorY)
    $("#w_preview" + selector).val(c.w * factorX)
