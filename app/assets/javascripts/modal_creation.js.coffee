$ = jQuery

$.fn.extend

  toModal: ->

    id = $(this).attr("id")

    $("#" + id).dialog appendTo: "body",
                       modal: true,
                       closeOnEscape: true,
                       dialogClass: 'noTitleStuff',
                       closeText: "hide",
                       width: 750,
                       height: "auto"

    $(".ui-dialog").css "padding", "0"
    $(".ui-dialog-content").css "padding", "0"
    $(".ui-dialog a").css "outline", "none"
    $(".ui-widget-overlay").css "opacity", ".80"
    $(".ui-widget-overlay").css "background-color", "rgb(0, 0, 0) 50% 50% repeat-x !important"
    $(".ui-widget-overlay").css "background-image", "none"
    $(".ui-dialog-titlebar").hide()
