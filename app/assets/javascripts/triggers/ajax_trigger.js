//Cuando hay una carga de contenido por AJAX, resetea todas las alturas y las iguala
$(document).ajaxComplete(function(event, xhr, settings) {
  var lugar = locationName();
  loadNeededScripts(lugar);
  resetUserContainerHeight();
  resetPpalContainerHeight();
  matchPrincipalContainersHeighs();

  $('body').removeClass("hidden_container");
});