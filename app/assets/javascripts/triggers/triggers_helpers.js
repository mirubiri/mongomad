
function loadNeededScripts(lugar){

  activateRequestButtons(); //Las peticiones siempre estan visibles

  if ( lugar === "offers" ) {
    resetPpalPadding();
    buildOfferMosaic();
    activateOfferButton();
  }
  else if ( lugar === "things" ) {
    resizeThings();
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
  var lugar = location.pathname.split("/")[ultimoPath].toString();
  //alert(lugar);

  return lugar;
}

function stopTimers(timers){
  for (var i = 0; i < timers.length; i++){
    clearTimeout(timers[i]);
  }
}

function variableNotDefined (name) {
    return typeof this[name] === 'undefined';
}