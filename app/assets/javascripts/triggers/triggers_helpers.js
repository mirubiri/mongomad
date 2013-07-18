
function loadNeededScripts(lugar){

  activateRequestButtons(); //Las peticiones siempre estan visibles

  if ( lugar === "offers" ) {
  }
  else if ( lugar === "things" ) {
  }
  else if ( lugar === "negotiations" ) {

  }
  else if ( lugar === "deals" ) {
  }
  else if ( lugar === "profile" ) {
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