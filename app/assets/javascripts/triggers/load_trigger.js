$(window).load(function(event){
  //alert("se dispara el load");

  event.stopPropagation();

  var lugar = locationName();
  //alert(lugar);

  loadNeededScripts(lugar);
  resetContainers();
  $('body').removeClass("hidden_container");
});