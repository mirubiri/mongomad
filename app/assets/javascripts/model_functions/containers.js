
(function ($)
{
  $.fn.regulateWidth = function(){
    var elementWidth = $(this).width();
    var regulateWidth = elementWidth - 10;
    $(this).css({'width': regulateWidth + 'px'});

    return $(this);
  };

})(jQuery);


(function ($)
{
  $.fn.setMargins = function (){
    //alert("entra en funcionamiento el setMargins");
    var ppalContainer = $(this).find('#ppal_container');
    var espacioUtil = ppalContainer.width();
    var offerWidth = ppalContainer.attr('offerWidth');
    //alert(offerWidth);
    var offersInRow = Math.floor(espacioUtil / offerWidth);
    //alert(offersInRow);

    var offersRowWidth = (offersInRow * offerWidth);
    //alert(offersRowWidht);
    var totalMargin = espacioUtil - offersRowWidth;
    var lateralMargin = totalMargin / 2;
    //alert(lateralMargin);

    $(this).css('padding-left', lateralMargin);
    $(this).css('padding-right', lateralMargin);

    return $(this);
  };


})(jQuery);






(function ($)
{
  $.fn.maximizeResizableChildren = function (){

    var fixedElementWidth = $(this).children('#leftContainer').outerWidth();
    var padding = $(this).css('padding-left').replace("px","");
    //alert(padding * 2);

    var maxWidth = $(this).innerWidth() - (padding * 2);
    //alert(maxWidth);
    var elementToDistribute = $(this).children('#rightContainer');
    var elementToDistributeWidth = maxWidth - fixedElementWidth;

    elementToDistribute.width(elementToDistributeWidth);
    //alert(elementToDistributeWidth);

    return $(this);
  };

})(jQuery);




(function ($)
{
  $.fn.expandToBodyWidth = function (){

    //alert("se lanza el expandToBodyWidth")

    //Cojo la anchura del body
    var bodyWidth = $(document.body).width();
    //alert("anchura del body:" + bodyWidth);

    //Paddings a 0px para no cometer errores en los calculos
    $(this).css('padding-left', "0px");
    $(this).css('padding-right', "0px");

    //Le pongo al Objeto la anchura total del body
    $(this).width(bodyWidth);
    //alert("anchura del main ajustada:" + $(this).css('width'));

    return $(this);
  };

})(jQuery);



(function ($)
{
  $.fn.refresh = function() {
    var elems = $(this.selector);
    this.splice(0, this.length);
    this.push.apply( this, elems );
    return this;
  };

})(jQuery);



(function ($)
{
  $.fn.resetContainerHeight = function() {

    var totalHeight = 0;

    $(this).children().each(function(){
        totalHeight += $(this).outerHeight(true);
    });

    $(this).height(totalHeight);

  };

})(jQuery);



(function ($)
{
  $.fn.matchPrincipalContainersHeighs = function() {

    //alert("matchPrincipalContainersHeighs funcionando");
    var alturaVentana = window.innerHeight - 80;


    // este if amplia hasta abajo la pantalla de login
    if ( ($('#loger_container').height()) < alturaVentana ) {
      $('#loger_container').css({'height': alturaVentana  + 'px'});
    }


    if(($('#ppal_container').height() + 42) > ($('#content-side').height())) {
      //alert("esta pasando");
      $('#content-side').css({'height': ($('#ppal_container').height() + 42)  + 'px'});
    }

    var alturaRequestContainerActualizada = $('#user_data_container').outerHeight(true) + $('#user_request_list').outerHeight(true) + 32;

    if(alturaRequestContainerActualizada > ($('#user-side').height())) {
      $('#user-side').css({'height': alturaRequestContainerActualizada  + 'px'});
    }

    if ( (($('#user-side').height()) < alturaVentana) && (($('#content-side').height()) < alturaVentana) ) {
      $('#user-side').css({'height': alturaVentana  + 'px'});
      $('#content-side').css({'height': alturaVentana  + 'px'});
    }else{
      $('#user-side,#content-side').equalHeightColumns();
    }

    if ( ($('#user-side').height()) === null ) {
      $('#footer').css({'top': (alturaVentana +60)  + 'px'});
    }else{
      $('#footer').css({'top': (($('#user-side').height()) + 55) + 'px'});
    }

  };

})(jQuery);



//Hago esta funcion porque todas estas llamadas juntas expanden nuestra web completa, y las uso todas a la vez en 2 sitios, en el load y cuando algo se carga por AJAX
function expandWeb(){

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

  //Si se pintan items rehago su tamaño
  $('.item').setItemWidth();

  activateRequestButtons(); //Las peticiones siempre estan visibles

  var lugar = locationName();

  if ( lugar === "offers" ) {}
  else if ( lugar === "items" ) {}
  else if ( lugar === "deals" ) {}
  else if ( lugar === "profile" ) {}
  else if ( lugar === "alerts" ) {}
  else {
    buildOfferMosaic();
    activateOfferButton();
  }

  $('body').removeClass("hidden_container");//Para firefox, ya que no lanza el eventoJS al cargar
}