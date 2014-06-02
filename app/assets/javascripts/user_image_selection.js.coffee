root = exports ? this

root.userImageChange = (input) ->  
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image = new Image()
      image.src = e.target.result      
      $("#user_image").find("img").attr "src", image.src
      return
    reader.readAsDataURL input.files[0]
  return
