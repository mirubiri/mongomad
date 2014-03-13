(function ($)
{
  $.fn.toModal = function(){

  	id = $(this).attr("id");

    $("#" + id).dialog({
		appendTo: "#body",
	    modal: true,
	    title: "",
		closeText: "hide",
		height: "auto",
		width: "auto",
	    open: function(){
	        jQuery('.ui-widget-overlay').bind('click',function(){
	            jQuery("#" + id).dialog('destroy').remove();
	        })
	    }
	});

  $(".ui-dialog-content").css( "padding", "0" ); // Modales sin padding gracias
  $(".ui-dialog a").css("outline", "none"); //quita la barra punteada de los links
	//$(".ui-dialog-titlebar").hide();// quita la barra de la modal
	$(".ui-widget-overlay").css( "opacity", ".80" ); // hacen el fondo mas oscuro
	$(".ui-widget-overlay").css( "background-color", "rgb(0, 0, 0) 50% 50% repeat-x !important" ); // hacen el fondo mas oscuro
	$(".ui-widget-overlay").css("background-image", "none"); // quita la franja

    return $(this);
  };

})(jQuery);
