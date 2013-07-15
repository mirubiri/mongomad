// Carga los scripts minimos si el usuario recarga la pagina en cualquier punto de navegacion
$(window).load(function(event){
  resetContainers();
  activateRequestButtons(); //Las peticiones siempre estan visibles

  var lugar = locationName();

  if ( lugar === "offers" ) {}
  else if ( lugar === "things" ) {}
  else if ( lugar === "deals" ) {}
  else if ( lugar === "profile" ) {}
  else if ( lugar === "alerts" ) {}
  else {
    buildOfferMosaic();
    activateOfferButton();
  }

});