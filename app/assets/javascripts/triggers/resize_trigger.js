//Carga los scripts necesarios y hace un reset de las alturas
$(window).bind('resize', function(event) {
  //alert("ha habido un resize");
  var lugar = locationName();
  loadNeededScripts(lugar);
  resetContainers();
  $('body').removeClass("hidden_container");
});