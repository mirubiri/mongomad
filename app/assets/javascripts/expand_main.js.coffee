@expandMain = ->
  $windowHeight = $(window).height()
  $omnibarHeight = $('#omnibar').outerHeight(true)
  $mainHeight = $windowHeight - $omnibarHeight - 20
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
