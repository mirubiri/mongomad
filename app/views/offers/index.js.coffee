//Contenido que debe cargar esta seccion: OFERTAS
$("#leftContainer").replaceWith("<%=j render :partial => 'application/user_container' %>");
$("#navigation_bar").html("<%=j render :partial => 'application/navigation_bar' %>");
$("#ppal_container").html("<%=j render (@offers) || 'no_offers' %>");


//Carga sus funciones especificas de dibujado
destroyMasonry();
activateMasonry();
activateOfferButton();
