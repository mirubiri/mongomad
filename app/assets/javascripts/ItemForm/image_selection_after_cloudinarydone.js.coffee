@imageSelectionFromCloudinaryInput = (data, selector) ->
  if data.files and data.files[0]

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

    reader.readAsDataURL data.files[0]
    setPreviewAsMain(selector)

  return
return
