@showCoords = (c, selector, factorX, factorY) ->
  $("#x_preview" + selector).val(c.x * factorX)
  $("#y_preview" + selector).val(c.y * factorY)
  $("#h_preview" + selector).val(c.h * factorY)
  $("#w_preview" + selector).val(c.w * factorX)

