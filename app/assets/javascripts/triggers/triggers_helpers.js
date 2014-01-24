
function loadNeededScripts(lugar){

  activateRequestButtons(); //Las peticiones siempre estan visibles

  if ( lugar === "offers" ) {
  }
  else if ( lugar === "items" ) {
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


function variableNotDefined (name) {
    return typeof this[name] === 'undefined';
}