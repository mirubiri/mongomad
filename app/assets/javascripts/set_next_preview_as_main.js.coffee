@setNextPreviewAsMain = (element) ->
  numOfMainPreview = $('[id^=main_preview][value="true"]').length

  if numOfMainPreview == 0
    $("[id^=main_preview]").first().attr "value","true"  
