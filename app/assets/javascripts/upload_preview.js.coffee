$ ->
  $(".cloudinary-fileupload").bind "cloudinarydone", (e, data) ->
    $(".preview").html $.cloudinary.image(data.result.public_id,
      format: data.result.format
      version: data.result.version
    )
    $(".image_public_id").val data.result.public_id
    true
