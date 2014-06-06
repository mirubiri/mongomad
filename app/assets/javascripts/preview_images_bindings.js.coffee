$(document).ready ->

  # Al pinchar en una de las previews, reemplaza la imagen principal por esta
  $ ->
    $(".add_image_container").on "click", "img", (event, data) ->
      $("#pan").find('img').attr "src", $(this).attr "src"      
      preview_number = $(this).parent().siblings(".preview_selector").children().first().children().first().attr "data-cloudinary-field"
      selector = preview_number.toString().substr(-1)

      addCropToSelector('#main_image',selector)
      return

  
  # Borra la preview al pulsar el boton '-'
  $ ->
    $(".delete_preview").on "click", (event) ->
      preview_number = $(this).siblings(".add_image_container").find("img").attr "id"
      selector = preview_number.toString().substr(-1)
      $(this).siblings(".add_image_container").find("img").remove()
      $(this).siblings(".add_image_container").prepend '<img src="" id="preview'+selector+'">'
      return


  $(".cloudinary-fileupload").on "change", ->
    select_number = $(this)
                      .attr "data-cloudinary-field"
                      .toString()
                      .substr(-1)
    imageSelection(this,select_number)
    return
