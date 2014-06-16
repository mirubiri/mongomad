$(document).ready ->

  # Al pinchar en una de las previews, reemplaza la imagen principal por esta
  $ ->
    $("#output").find('img').each ->
      element = $(this)

      preview_number = element.attr "id"
      selector = preview_number.toString().substr(-1)

      imageSelectionBeforeItemEdition(element,selector)
      element.remove()
      return



