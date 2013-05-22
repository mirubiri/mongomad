function resetContainers(){
  resetUserContainerHeight();
  resetPpalContainerHeight();
  matchPrincipalContainersHeighs();
  expandContainers();  
}

function resetUserContainerHeight(){
  //alert("resetUserContainerHeight funcionando");  

  var profileHeight = $("#user_data_container").outerHeight(true);
  var requestsHeight = $("#user_request_list").outerHeight(true);
  var totalHeight = profileHeight + requestsHeight +32; //el 32 es de la navbar

  $('#user-side').css({'height': totalHeight  + 'px'});
}


function resetPpalContainerHeight(){
  //alert("resetPpalContainerHeight funcionando");  

  var elementListHeight = $("#ppal_container").outerHeight(true);
  var navigatioBarHeight = $("#navigation_bar").outerHeight(true);
  var totalHeight = elementListHeight + navigatioBarHeight;

  $('#content-side').css({'height': totalHeight  + 'px'});
}


function matchPrincipalContainersHeighs(){
  //alert("matchPrincipalContainersHeighs funcionando");  
  var alturaVentana = $(document).height()-80;

  // este if amplia hasta abajo la pantalla de login
  if ( ($('#devise_container').height()) < alturaVentana ) {
    $('#devise_container').css({'height': alturaVentana  + 'px'});
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
}


function expandContainers(){
  //alert("expandContainers funcionando");

  setRightContainerWidth();
  centerContentSide();
}


function setRightContainerWidth(){

  if (existScroll() === true){
    var anchuraMainLayout = $('.mainlayout').innerWidth();
  }else {
    var anchuraMainLayout = $('.mainlayout').innerWidth() -15;
  }

  console.log("anchura del mainLayout: "+anchuraMainLayout);

  var leftWidth = $('#leftContainer').outerWidth( true );
  console.log("anchura del contenedor de la izda: "+leftWidth); 

  var rightWidth = anchuraMainLayout - leftWidth -2;// bordes del rightContainer mas la anchura de la scrollbar
  console.log("calculo para la nueva anchura del right_container: "+rightWidth);
  $('#rightContainer').css({'width': rightWidth + 'px'});

  rightWidth = $('#rightContainer').width();
  console.log("anchura del contenedor de la dcha: "+rightWidth);  

  contentSideWidth = $('#content-side').width();
  console.log("anchura del content-side: "+ contentSideWidth);

}


function centerContentSide(){
  var anchuraPosible = ($('#ppal_container').width()) - 16;
  var anchuraPrincipalElement = 260;// La anchura de una oferta
  var elementosEntran = offersFit(anchuraPrincipalElement,anchuraPosible);  

  var anchuraQueQuitar = anchuraPosible - (anchuraPrincipalElement * elementosEntran);
  console.log("anchura que quitar: "+anchuraQueQuitar);  

  if( anchuraQueQuitar > 0 ){
    var rightContainer = $('#rightContainer');
    var rightContainerWidth = rightContainer.width();
    var finalRightContainerWidth = rightContainerWidth - anchuraQueQuitar;
    rightContainer.css({'width': finalRightContainerWidth  + 'px'});
    centerAlignToContainers(anchuraQueQuitar);
  }  
}


function offersFit(elementWidth,totalWidth){
  var disparador = elementWidth;
  var contador = 1;
  var elementosEntran = 0;

  while(disparador < totalWidth){
     disparador = disparador + disparador;
     contador = contador + 1;
  }

  var elementosEntran = contador;
  console.log("¿cuantas ofertan entran?: "+elementosEntran);
  return elementosEntran;
}


function centerAlignToContainers(anchuraQueQuitar){
  var anchuraTotalPagina = $(document).width();
  var mainLayout = $('.mainlayout');
  margenPorRepartirPorcentual = (anchuraQueQuitar * 100) / anchuraTotalPagina;
  anchuraMainLayoutRecalculada = 97 - margenPorRepartirPorcentual;
  mainLayout.css({'width': anchuraMainLayoutRecalculada + '%'});


  console.log("margen a repartir porcentual: "+margenPorRepartirPorcentual);
  console.log("anchura del mainLayout porcentual recalculada: "+anchuraMainLayoutRecalculada);
  console.log("entra en el algoritmo de modificacion");
}

function existScroll(){
  if ($(document).height() > $(window).height()) {
    return true;
  } else {
    return false;
  }
}