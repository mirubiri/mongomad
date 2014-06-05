$(document).ready ->

  # Al pinchar en una de las previews, reemplaza la imagen principal por esta
  $ ->
    $(".add_image_container").on "click", "img", (event, data) ->
      $("#pan").find('img').attr "src", $(this).attr "src"      
      preview_number = $(this).parent().siblings(".preview_selector").children().first().children().first().attr "data-cloudinary-field"
      selector = preview_number.toString().substr(-1)

      $('#main_image').Jcrop
        onSelect: (coords) ->
                    showCoords coords,selector
                    showPreview coords,selector
        onChange: (coords) ->
                    showCoords coords,selector
                    showPreview coords,selector
        bgColor: 'white',
        bgOpacity: 0.8,
        setSelect: [ 100, 100, 50, 50 ],
        aspectRatio: 1

      return

  # Borra la preview al pulsar el boton '-'
  $ ->
    $(".delete_preview").on "click", (event) ->
      $(this).closest(".add_image_container").find(".hidden_image_input").remove()
      $(this).closest(".add_image_container").find("img").remove()
      $(this).closest(".add_image_container").prepend "<img src=''>"
      return
