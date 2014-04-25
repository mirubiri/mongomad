//Contenido que debe cargar esta seccion: TRATOS
$("#leftContainer").replaceWith("<%=j render :partial => 'application/user_container' %>");
$("#navigation_bar").html("<%=j render :partial => 'application/navigation_bar' %>");
$("#ppal_container").html("<%=j render @deals || 'no_deal' %>");



//Carga sus funciones especificas de dibujado
$('.deal').regulateWidth();
$('.deal').maximizeConversationWidth();
$('.deal').maximizeConversationsHeights();
$('.deal').activateNegotiationButtons();
//$('.deal').disableDoubleScrolling();
$('.deal').focusNegotiationWritebox();
$('.deal').scrollConversation();

//Controlo el evento de ponerse encima de un item
$('.image_container').hideTitle();


//Si le doy al enter en cualquier conversacion, envia el texto si el textarea esta activado claro
$('.txt_area_writer').keypress(function(event) {
  if (event.which == 13) {
    //alert("enter key pressed");
    event.preventDefault();
    $(this).closest("form").submit();
  }
});

//Carga sus funciones especificas de dibujado
destroyMasonry();
