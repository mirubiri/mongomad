//Lo primero es eliminar las modales que se hayan podido quedar perdidas
$('#new-offer-form').remove();
$('#edit-offer-form').remove();

//Agregamos el elemento en el ppal_container con una transicion para que el usuario vea como se añade
$("#navigation_bar").html("<%=j render :partial => 'application/navigation_bar' %>");
$("#leftContainer").replaceWith("<%=j render :partial => 'application/user_container' %>");
$("#ppal_container").html("<%=j render @offers %>");

//Si estabamos mostrando el contenido de que no hay ofertas, lo eliminamos
if( ($('.offer').length) === 0){
  $('#ppal_container > .no_elements').remove();
}

$('#ppal_container').children().last().remove();

//Agregamos el elemento en el ppal_container con una transicion para que el usuario vea como se añade
$('#ppal_container')
.prepend("<%= escape_javascript(render template: 'offers/show', :locals => {:offer => offer, :@negotiation => Negotiation.new}).html_safe %>")
.children()
.first()
.addClass("new_request_style")
.css('opacity', 0)
.hide()
.slideDown()
.animate(
  { opacity: 1 },
  { queue: false, duration: 1500 }
)
.animate({backgroundColor: '#ffffff'}, 800, function(){
  $(this).removeClass("new_request_style");
});

activateMasonry();
matchPrincipalContainersHeighs();

  //Elimino la ventana modal de forma definitiva, si no lo hago y abro una nueva, pese a que esté hide, los procesos se lanzaran para cada una
  //delete $(this);
//});

