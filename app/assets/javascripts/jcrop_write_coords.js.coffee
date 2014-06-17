@writeCoords = (c, selector) ->  
  $("#coordinates" + selector).attr "cropX1",c.x
  $("#coordinates" + selector).attr "cropY1",c.y
  $("#coordinates" + selector).attr "cropX2",c.x2
  $("#coordinates" + selector).attr "cropY2",c.y2
