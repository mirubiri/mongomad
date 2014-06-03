$(document).ready ->

  # Al pinchar en una de las previews, reemplaza la imagen principal por esta
  $ ->
    $(".add_image_container").on "click", "img", (event, data) ->
      $("#pan").find('img').attr "src", $(this).attr "src"      
      # $("#pan").find('img').attr "src",$.cloudinary.image(data.result.public_id,
      #   format: data.result.format
      #   version: data.result.version
      # ).attr "src"
      preview_number = $(this).siblings(".preview_selector").children().first().children().first().attr "data-cloudinary-field"
      draggandcrop("#pan img", preview_number)        
      return

  # Borra la preview al pulsar el boton '-'
  $ ->
    $(".input_container").on "click", ".delete_image_selected", (event) ->
      $(this).closest(".add_image_container").find(".hidden_image_input").remove()
      $(this).closest(".add_image_container").find("img").remove()
      $(this).closest(".add_image_container").prepend "<img src=''>"
      return
