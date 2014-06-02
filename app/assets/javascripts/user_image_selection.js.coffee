userImageChange = (input) ->
  input_selector = selector.toString()
  
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      alert("imagen cargada")
      image = new Image()
      image.src = e.target.result      
      $("#user_image").find("img").attr "src", @src
      return
    reader.readAsDataURL input.files[0]
  return


$ ->
  $(".add_image_container").on "click", "img", (event) ->
    alert("imagen pinchada")
    unless $(this).attr("src") is ""
      image = $(this).clone()
      $("#original_image_container").find("img").replaceWith image
    return

$ ->
  $(".input_container").on "click", ".delete_image_selected", (event) ->
    $(this).closest(".add_image_container").find(".hidden_image_input").remove()
    $(this).closest(".add_image_container").find("img").remove()
    $(this).closest(".add_image_container").prepend "<img src=''>"
    return
