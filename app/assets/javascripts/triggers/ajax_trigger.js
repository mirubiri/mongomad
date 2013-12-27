//Cuando hay una carga de contenido por AJAX, resetea todas las alturas y las iguala
$(document).ajaxComplete(function(event, xhr, settings) {

  //alert("algo se ha cargado por JS");
  
  // Expando toda la web a su tamaño maximo
  expandWeb();
});