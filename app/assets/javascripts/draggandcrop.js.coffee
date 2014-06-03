@draggandcrop = (selector, preview_number) ->
  if preview_number == "image1"
    $(selector).panZoom
      zoomIn: $("#zoomin")
      zoomOut: $("#zoomout")      
      out_x1: $("#x1_preview1")
      out_y1: $("#y1_preview1")
      out_x2: $("#x2")
      out_y2: $("#y2")
      debug: false
  if preview_number == "image2"
    $(selector).panZoom
      zoomIn: $("#zoomin")
      zoomOut: $("#zoomout")      
      out_x1: $("#x1_preview2")
      out_y1: $("#y1_preview2")
      out_x2: $("#x2")
      out_y2: $("#y2")
      debug: false
  if preview_number == "image3"
    $(selector).panZoom
      zoomIn: $("#zoomin")
      zoomOut: $("#zoomout")      
      out_x1: $("#x1_preview3")
      out_y1: $("#y1_preview3")
      out_x2: $("#x2")
      out_y2: $("#y2")
      debug: false
