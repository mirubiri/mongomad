
function loadNeededScripts(lugar){
  if ( lugar === "offers" ) {
    buildOfferMosaic();
    activateOfferButton();
  }
  else if ( lugar === "things" ) {
     buildThingMosaic();
  }
  else if ( lugar === "negotiations" ) {
    destroyMasonry();
    maximizeConversationWidth();
    maximizeConversationsHeights();
    activateNegotiationButtons();
  }
  else if ( lugar === "deals" ) {
    destroyMasonry();
  }
  else if ( lugar === "profile" ) {
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