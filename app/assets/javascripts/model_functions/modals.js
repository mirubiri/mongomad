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
	            jQuery("#" + id).dialog('close');
	        })
	    }	 
	});

	$(".ui-dialog-titlebar").hide();// quita la barra de la modal
	$(".ui-widget-overlay").css( "opacity", ".80" ); // hacen el fondo mas oscuro
	$(".ui-widget-overlay").css( "background-color", "rgb(0, 0, 0) 50% 50% repeat-x !important" ); // hacen el fondo mas oscuro
	$(".ui-widget-overlay").css("background-image", "none"); // quita la franja

    return $(this);
  };

})(jQuery);