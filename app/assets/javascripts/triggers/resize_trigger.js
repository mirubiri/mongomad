//Carga los scripts necesarios y hace un reset de las alturas

$(window).resize(function () {
    whenEventFinish(function(){
      //alert('Resize...');

      //Expando el contenedor principal y reseteo sus margenes para ajustarlos a los elementos de la lista
      $('#mainLayout').expandToBodyWidth();
      $('#mainLayout').maximizeResizableChildren();
      $('#mainLayout').setMargins();
      $('#mainLayout').maximizeResizableChildren();
      $('.header').setHeaderPadding();


      //Reseteo las alturas de los contenedores principales y las igualo
      $("#user-side").resetContainerHeight();
      $("#content-side").resetContainerHeight();
      $('#mainLayout').matchPrincipalContainersHeighs();



      var lugar = locationName();
      loadNeededScripts(lugar);
      //resetContainers();


    });

    $('body').removeClass("hidden_container");
});