//Cuando hay una carga de contenido por AJAX, resetea todas las alturas y las iguala
$(document).ajaxComplete(function(event, xhr, settings) {



  //Hago visible el body
  $('body').removeClass("hidden_container");
});