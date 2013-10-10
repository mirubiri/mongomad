//Cuando hay una carga de contenido por AJAX, resetea todas las alturas y las iguala
$(document).ajaxComplete(function(event, xhr, settings) {

  //alert("algo se ha cargado por JS");

  //Reseteo las alturas de los contenedores principales y las igualo
  $("#user-side").resetContainerHeight();
  $("#content-side").resetContainerHeight();
  $('#mainLayout').matchPrincipalContainersHeighs();


  //Hago visible el body
  $('body').removeClass("hidden_container");
});