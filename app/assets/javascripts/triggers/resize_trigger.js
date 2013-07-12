$(window).bind('resize', function(event) {
  //alert("ha habido un resize");
  //event.stopPropagation();

  var lugar = locationName();
  //alert(lugar);

  loadNeededScripts(lugar);
  resetContainers();
  $('body').removeClass("hidden_container");
});