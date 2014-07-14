$(window).load (event) ->
  $windowHeight = $(window).height()
  $billboardHeight = $('#billboard').outerHeight(true)
  $footerHeight = $('#footer').outerHeight(true)
  $mainHeight = $windowHeight - $billboardHeight - $footerHeight - 60
  $dashboardHeight = $('#dashboard').height()
  $expositorHeight = $('#expositor').height()

  $('#dashboard').height($mainHeight) if $dashboardHeight < $mainHeight
  $('#expositor').height($mainHeight) if $expositorHeight < $mainHeight

  $("#dashboard,#expositor").equalHeightColumns()
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
  $dashboardHeight = $('#dashboard').height()
  $expositorHeight = $('#expositor').height()

  $('#dashboard').height($mainHeight) if $dashboardHeight < $mainHeight
  $('#expositor').height($mainHeight) if $expositorHeight < $mainHeight

  $("#dashboard,#expositor").equalHeightColumns()
  $(".overridesPadding").each ->
    $width = $(this).parent().outerWidth() - 2
    $(this).width($width)
    return
  return
