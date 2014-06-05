@imageSelection = (input, selector) ->

  $(".cloudinary-fileupload").bind "cloudinarydone" , (e, data) ->  

    if input.files and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->

        image = new Image()
        image.src = e.target.result

        $(".progress_bar").width(0)

        $(".preview").find('img')
          .attr "src", image.src
          .attr "id","main_image"

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

        image.onload = (event) ->
          $("#inputcontainer" + selector).find("img").attr "src", image.src          
          return
        
        return

      reader.readAsDataURL input.files[0]

    return
  return
