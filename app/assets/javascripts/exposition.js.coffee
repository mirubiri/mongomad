$(window).load (event) ->
  $windowHeight = $(window).height()
  $billboardHeight = $('#billboard').outerHeight(true)
  $footerHeight = $('#footer').outerHeight(true)
  $mainHeight = $windowHeight - $billboardHeight - $footerHeight - 60
  $profileHeight = $('#profile').height()
  $expositorHeight = $('#expositor').height()

  $('#profile').height($mainHeight) if $profileHeight < $mainHeight
  $('#expositor').height($mainHeight) if $expositorHeight < $mainHeight

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
  $profileHeight = $('#profile').height()
  $expositorHeight = $('#expositor').height()

  $('#profile').height($mainHeight) if $profileHeight < $mainHeight
  $('#expositor').height($mainHeight) if $expositorHeight < $mainHeight

  $("#profile,#expositor").equalHeightColumns()
  $(".overridesPadding").each ->
    $width = $(this).parent().outerWidth() - 2
    $(this).width($width)
    return
  return
