function reloadPrincipalContainersHeighs(){
  $('#ppal_container').css({'height': 0  + 'px'});
  $('#user-side').css({'height': 0  + 'px'});
  $('#content-side').css({'height': 0  + 'px'});
}

function matchPrincipalContainersHeighs(){
  var alturaVentana = $(document).height()-80;

  if ( ($('#devise_container').height()) < alturaVentana ) {
      $('#devise_container').css({'height': alturaVentana  + 'px'});
  }
  if ( ($('#user-side').height()) < alturaVentana ) {
      $('#user-side').css({'height': alturaVentana  + 'px'});
  }

  $('#user-side,#content-side').equalHeightColumns();
  $('#ppal_container').css({'height': ($('#user-side').height() - 70)  + 'px'});

  if ( ($('#user-side').height()) === null ) {
    $('#footer').css({'top': (alturaVentana +60)  + 'px'});
  }else{
    $('#footer').css({'top': (($('#user-side').height()) + 55) + 'px'});
  }
}

function expandContainers(){

  // Aqui empieza el calculo de las anchuras *************************

  mainLayout = $('.mainlayout');
  anchuraTotalPagina = $(document).width();
  anchuraTotalUtilizada = (anchuraTotalPagina * 97)/100;
  mainLayout.css({'width': anchuraTotalUtilizada + 'px'}); // Reseteo la anchura al 97% del total del documento HTML
  anchuraMainLayout = mainLayout.width();

  leftWidth = $('#leftContainer').width();
  rightWidth = anchuraMainLayout - leftWidth - 20;
  $('#rightContainer').css({'width': rightWidth + 'px'});


  anchuraPosible = ($('#ppal_container').width()) - 16; // Anchura del contenedor de la lista de elementos principales
  javascript:console.log(anchuraPosible);
  anchuraOffer = ($('.offer:first').width()) + 2; // Anchura de la offer(luego sera la del primer elemento)
  //console.log(anchuraOffer);

  disparador = anchuraOffer;
  contador = 0;

  while(disparador < anchuraPosible){
   disparador = disparador + anchuraOffer;
   contador = contador + 1
  }

  offersEntran = contador; // Estas son las ofertas que entran el el contenedor principal de elementos
  //console.log(offersEntran);
  margenPorRepartir = anchuraPosible - (anchuraOffer*offersEntran);// El margen que falta por cubrir
  //console.log(margenPorRepartir);

  //******************************************************************

  anchuraMainLayout = mainLayout.width();
  margenPorRepartirPorcentual = (margenPorRepartir * 100) / anchuraTotalPagina;
  //console.log(margenPorRepartirPorcentual);

  anchuraMainLayoutRecalculada = 97 - margenPorRepartirPorcentual;
  //alert(anchuraMainLayoutRecalculada);

  if(anchuraOffer > 10){
    mainLayout.css({'width': anchuraMainLayoutRecalculada + '%'});
    anchuraMainLayout = $('.mainlayout').width();//reinicio el selector

    leftWidth = $('#leftContainer').width();
    rightWidth = anchuraMainLayout - leftWidth - 20;

    $('#rightContainer').css({'width': rightWidth + 'px'});
  }

}