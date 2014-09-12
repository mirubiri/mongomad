$ ->
  $(".requester textarea").siblings().hide();

  $(".requester").focusin ->
    $(this).find("textarea").animate({height: "90px"}, 0)
    $(this).find("textarea").siblings().show()
    return

  $(".requester").focusout ->
    $(this).find("textarea").animate({height: "50px"}, 0)
    $(this).find("textarea").siblings().hide()
    return
