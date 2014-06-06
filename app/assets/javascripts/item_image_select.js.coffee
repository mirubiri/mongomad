@imageSelection = (input, selector) ->

  $(".cloudinary-fileupload").bind "cloudinarydone" , (e, data) ->      

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
          addCoordinates(selector)
          addCropToSelector('#main_image',selector, factorX, factorY)
          $("#inputcontainer" + selector).find("img").attr "src", image.src          
          return
        
        return

      reader.readAsDataURL input.files[0]

    return
  return



reloadProgressBar = ->
  $(".progress_bar").width(0)


setPreviewImage = (image) ->
  $(".preview").find('img')
    .removeAttr "src"

  $(".preview").find('img')
    .attr "src", image.src
    .attr "id","main_image"
