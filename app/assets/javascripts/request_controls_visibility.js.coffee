$ ->
  $(".request").mouseenter ->
    $(this).find('.controls').css 'visibility','visible'
  $(".request").mouseleave ->
    $(this).find('.controls').css 'visibility','hidden'
  return
