// Carga los scripts necesarios (esto cambiará 'dynamic javascript loading' -> en la barra de marcadores), y resetea las alturas de los elementos
$(window).load(function(event){
  resetContainers();
  var lugar = locationName();
  loadNeededScripts(lugar);
});