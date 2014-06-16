@imageSelectionFromCloudinaryInput = (input, selector) ->
  # El selector me previene del bubbling sobre el resto de inputs de cloudinary
  $("input[data-cloudinary-field='image"+selector+"']").on "cloudinarydone" , (e, data) -> 

    if input.files and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        image = new Image()
        image.src = e.target.result

        image.onload = (event) ->

          originalWidth = this.width
          originalHeight = this.height
          showedWidth = $("#pan").width()
          showedHeight = $("#pan").height()
          factorX = originalWidth/showedWidth
          factorY = originalHeight/showedHeight

          reloadProgressBar()
          setPreviewImage(image)

          deleteCoordinatesBlock(selector)
          addCoordinates(selector)
          addCropToSelector('#main_image',selector, factorX, factorY)
          setCoordinatesIdasCloudinaryId(selector)

          $("#inputcontainer" + selector).find("img").attr "src", image.src
          $("#coordinates" + selector).attr "factorX", factorX
          $("#coordinates" + selector).attr "factorY", factorY
          return
        
        return

      reader.readAsDataURL input.files[0]
      setPreviewAsMain(selector)
      
    return
  return
