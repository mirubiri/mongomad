@imageSelection = (input, selector) ->
  input_selector = selector.toString()
  
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image = new Image()
      image.src = e.target.result
      if input_selector is "image1"
        image.onload = (event) ->
          $("#inputcontainer1").find("img").attr "src", image.src          
          return
      else if input_selector is "image2"
        image.onload = (event) ->
          $("#inputcontainer2").find("img").attr "src", image.src           
          return
      else
        image.onload = (event) ->
          $("#inputcontainer3").find("img").attr "src", image.src           
          return
      return

    reader.readAsDataURL input.files[0]
  return
