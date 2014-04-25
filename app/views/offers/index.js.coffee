//Contenido que debe cargar esta seccion: OFERTAS
$("#leftContainer").replaceWith("<%=j render :partial => 'application/user_container' %>");
$("#navigation_bar").html("<%=j render :partial => 'application/navigation_bar' %>");
$("#ppal_container").html("<%=j render partial: 'offer', collection: @offers, layout: 'as-offer' || 'zero_offers' %>");


//Carga sus funciones especificas de dibujado
destroyMasonry();
activateMasonry();
activateOfferButton();
