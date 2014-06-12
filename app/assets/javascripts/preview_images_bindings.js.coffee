$(document).ready ->

  # Al pinchar en una de las previews, reemplaza la imagen principal por esta
  $ ->
    $(".add_image_container").on "click", "img", (event, data) ->

      replaceMainWidthPreview($(this))
      preview_selected = previewNumberFromAddImageButton($(this))
      
      factorX = $("#coordinates" + preview_selected).attr "factorX"
      factorY = $("#coordinates" + preview_selected).attr "factorY"

      deleteCoordinatesOfPreviewFromImage($(this))
      addCoordinates(preview_selected)

      $("#coordinates" + preview_selected).attr "factorX", factorX
      $("#coordinates" + preview_selected).attr "factorY", factorY

      addCropToSelector('#main_image',preview_selected,factorX,factorY)
      imageSelectionFromCloudinaryInput($(this),preview_selected)      
      setPreviewAsMain(preview_selected)
      return

  
  # Borra la preview al pulsar el boton '-'
  $ ->
    $(".delete_preview").on "click", (event) ->
      deleteCoordinatesOfPreview($(this))
      deleteMainImage()
      deletePreviewSelected($(this))
      deleteHiddenInputForPreview($(this))
      return


  $ ->
    $(".preview_selector").on "click", (event) ->
      deleteCoordinatesOfPreview($(this))
      return


  $(".cloudinary-fileupload").on "change", ->
    select_number = $(this)
                      .attr "data-cloudinary-field"
                      .toString()
                      .substr(-1)
    imageSelectionFromCloudinaryInput(this,select_number)
    return






deleteMainImage = ->
  element = $("#pan")
  element.children().remove()
  element.append("<img id='main_image' src>")


deletePreviewSelected = (element) ->
  preview_number = element.siblings(".add_image_container").find("img").attr "id"
  selector = preview_number.toString().substr(-1)
  element.siblings(".add_image_container").find("img").remove()
  element.siblings(".add_image_container").prepend '<img src="" id="preview'+selector+'">'


deleteHiddenInputForPreview = (element) ->
  preview_number = element.siblings(".add_image_container").attr "id"
  selector = preview_number.toString().substr(-1)
  $('input:hidden[name=image'+selector+']').remove()


replaceMainWidthPreview = (element) ->
  $("#pan").find('img').attr "src", element.attr "src"      


previewNumberFromAddImageButton = (element) ->
  preview_number = element.parent().siblings(".preview_selector").children().first().children().first().attr "data-cloudinary-field"
  selector = preview_number.toString().substr(-1)
  return selector

deleteCoordinatesOfPreview = (element) ->
  preview_number = element.siblings(".add_image_container").attr "id"
  selector = preview_number.toString().substr(-1)
  $('#coordinates'+selector+'').remove()  


deleteCoordinatesOfPreviewFromImage = (element) ->
  preview_number = element.parent(".add_image_container").attr "id"
  selector = preview_number.toString().substr(-1)
  $('#coordinates'+selector+'').remove() 
