$(document).ajaxComplete(function(event, xhr, settings) {

  //alert("algo ha pasado por ajax");
  //event.stopPropagation();

  var lugar = locationName();
  //alert(lugar);

  loadNeededScripts(lugar);
  resetUserContainerHeight();
  resetPpalContainerHeight();
  matchPrincipalContainersHeighs();

  $('body').removeClass("hidden_container");
});