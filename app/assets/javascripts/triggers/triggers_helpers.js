
function loadNeededScripts(lugar){

  activateRequestButtons(); //Las peticiones siempre estan visibles

  if ( lugar === "offers" ) {
    resetPpalPadding();
    buildOfferMosaic();
    activateOfferButton();
  }
  else if ( lugar === "things" ) {
  }
  else if ( lugar === "negotiations" ) {
    destroyMasonry();
    maximizeConversationWidth();
    maximizeConversationsHeights();
    activateNegotiationButtons();
    focusNegotiationWritebox();
    scrollConversation();
  }
  else if ( lugar === "deals" ) {
    destroyMasonry();
  }
  else if ( lugar === "profile" ) {
    destroyMasonry();
    setProfileContainersHeights();
    addProfileCommentsSeparator();
  }
  else if ( lugar === "alerts" ) {
    destroyMasonry();
  }
  else {
    buildOfferMosaic();
    activateOfferButton();
  }
}

function locationName(){
  var pagina = location.pathname.split("/");
  var ultimoPath = pagina.length-1;
  var lugar = location.pathname.split("/")[ultimoPath];
  //alert(lugar);

  return lugar;
}