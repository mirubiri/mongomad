$(window).load(function(event){
  //alert("se dispara el load");
  //event.stopPropagation();
  resetContainers();

  var lugar = locationName();
  //alert(lugar);

  loadNeededScripts(lugar);

  $('body').removeClass("hidden_container");
});