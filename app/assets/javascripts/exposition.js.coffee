$(window).load (event) ->
  $windowHeight = $(window).height()
  $billboardHeight = $('#billboard').outerHeight(true)
  $footerHeight = $('#footer').outerHeight(true)
  $mainHeight = $windowHeight - $billboardHeight - $footerHeight - 60
  $('body').height($windowHeight)
  $('#profile').height($mainHeight)
  $("#profile,#expositor").equalHeightColumns()

  $(".overridesPadding").each ->
    $width = $(this).parent().outerWidth() - 2
    $(this).width($width)
    return

  return

$(window).resize (event) ->
  $windowHeight = $(window).height()
  $billboardHeight = $('#billboard').outerHeight(true)
  $footerHeight = $('#footer').outerHeight(true)
  $mainHeight = $windowHeight - $billboardHeight - $footerHeight - 60
  $('body').height($windowHeight)
  $('#profile').height($mainHeight)
  $("#profile,#expositor").equalHeightColumns()
  return
