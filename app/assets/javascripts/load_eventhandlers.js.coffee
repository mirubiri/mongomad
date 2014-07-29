window.onload = ->
  expandMain()
  $(".requester textarea").characterCountdown
    countdownTarget: ".countdown" # the class, ID or element that will display the countdown
    maxChars: 160 #  the maximum amount of characters
  return
