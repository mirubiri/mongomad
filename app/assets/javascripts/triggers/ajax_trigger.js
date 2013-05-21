$(document).ajaxComplete(function(event, xhr, settings) {
  //alert("algo ha pasado por ajax");

  event.stopPropagation();
  resetContainers();

  var lugar = locationName();
  //alert(lugar);

  loadNeededScripts(lugar);
  $('body').removeClass("hidden_container");
});