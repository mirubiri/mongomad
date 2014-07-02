@setPreviewAsMain = (selector) ->
  $("input[id^='main_preview']").attr "value","false"
  $('input[id="main_preview'+selector+'"]').attr "value","true"


