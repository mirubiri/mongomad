@showCoords = (c, selector) -> 
  $("#x_preview" + selector).val(c.x)
  $("#y_preview" + selector).val(c.y)
  $("#h_preview" + selector).val(c.h)
  $("#w_preview" + selector).val(c.w)

