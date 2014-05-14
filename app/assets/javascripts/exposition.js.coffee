$(window).load (event) -> 
  $windowHeight = $(window).height()
  $billboardHeight = $('#billboard').outerHeight(true)
  $footerHeight = $('#foothe').outerHeight(true)
  $mainHeight = $windowHeight - $billboardHeight - $footerHeight - 60
  $('body').height($windowHeight)
  $('#profile').height($mainHeight)
  $("#profile,#expositor").equalHeightColumns()
  return

$(window).resize (event) -> 
  $windowHeight = $(window).height()
  $billboardHeight = $('#billboard').outerHeight(true)
  $footerHeight = $('#foothe').outerHeight(true)
  $mainHeight = $windowHeight - $billboardHeight - $footerHeight - 60
  $('body').height($windowHeight)
  $('#profile').height($mainHeight)
  $("#profile,#expositor").equalHeightColumns()
  return
