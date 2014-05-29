imageSelection = (input, selector) ->
  input_selector = selector.toString()
  
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image = new Image()
      image.src = e.target.result
      if input_selector is "1"
        image.onload = (event) ->
          $("#inputcontainer1").find("img").attr "src", @src
          image = $("#inputcontainer1").find("img").clone()
          $("#original_image_container").find("img").replaceWith image
          return
      else if input_selector is "2"
        image.onload = (event) ->
          $("#inputcontainer2").find("img").attr "src", @src
          image = $("#inputcontainer2").find("img").clone()
          $("#original_image_container").find("img").replaceWith image
          return
      else
        image.onload = (event) ->
          $("#inputcontainer3").find("img").attr "src", @src
          image = $("#inputcontainer3").find("img").clone()
          $("#original_image_container").find("img").replaceWith image
          return
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
