$(window).bind('resize', function(event) {
  //alert("ha habido un resize");

  event.stopPropagation();  
  resetContainers();
  
  var lugar = locationName();
  //alert(lugar);

  loadNeededScripts(lugar);
  $('body').removeClass("hidden_container");
});