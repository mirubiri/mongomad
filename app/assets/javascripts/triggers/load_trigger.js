// Carga los scripts minimos si el usuario recarga la pagina en cualquier punto de navegacion
$(window).load(function(event){

  $('#mainLayout').expandToBodyWidth();
  $('#mainLayout').maximizeResizableChildren();
  $('#mainLayout').setMargins();
  $('#mainLayout').maximizeResizableChildren();
  $('.header').setHeaderPadding();

  activateRequestButtons(); //Las peticiones siempre estan visibles

  var lugar = locationName();

  if ( lugar === "offers" ) {}
  else if ( lugar === "items" ) {}
  else if ( lugar === "deals" ) {}
  else if ( lugar === "profile" ) {}
  else if ( lugar === "alerts" ) {}
  else {
    buildOfferMosaic();
    activateOfferButton();
  }

  $('body').removeClass("hidden_container");//Para firefox, ya que no lanza el eventoJS al cargar
});