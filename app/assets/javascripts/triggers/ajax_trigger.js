$(document).ajaxComplete(function(event, xhr, settings) {

  //alert("algo ha pasado por ajax");
  var pagina = location.pathname.split("/");
  var ultimoPath = pagina.length-1;
  var lugar = location.pathname.split("/")[ultimoPath];

  //alert(lugar);
  resetContainers();

  if ( lugar === "offers" ) {
    buildOfferMosaic();
    activateOfferButton();
  }
  else if ( lugar === "things" ) {
     buildThingMosaic();
  }
  else if ( lugar === "profile" ) {
    setProfileContainersHeights();
    addProfileCommentsSeparator();
  }
  else if ( lugar === "negotiations" ) {
    activateNegotiationButtons();
    maximizeConversationWidth();
  }

  $('body').removeClass("hidden_container");
});