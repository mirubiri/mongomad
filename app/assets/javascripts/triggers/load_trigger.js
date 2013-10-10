// Carga los scripts minimos si el usuario recarga la pagina en cualquier punto de navegacion
$(window).load(function(event){

  //Expando el contenedor principal y reseteo sus margenes para ajustarlos a los elementos de la lista
  $('#mainLayout').expandToBodyWidth();
  $('#mainLayout').maximizeResizableChildren();
  $('#mainLayout').setMargins();
  $('#mainLayout').maximizeResizableChildren();
  $('.header').setHeaderPadding();

  //Si se pintan items rehago su tamaño
  $('.item').setItemWidth();

  //Reseteo las alturas de los contenedores principales y las igualo
  $("#user-side").resetContainerHeight();
  $("#content-side").resetContainerHeight();
  $('#mainLayout').matchPrincipalContainersHeighs();

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