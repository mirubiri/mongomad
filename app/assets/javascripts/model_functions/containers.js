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

  $('#ppal_container').hide();

  // Aqui empieza el calculo de las anchuras *************************

  mainLayout = $('.mainlayout');
  anchuraTotalPagina = $(document).width();
  console.log("anchura del body: "+anchuraTotalPagina);
  anchuraTotalUtilizada = (anchuraTotalPagina * 97)/100;
  console.log("anchura del mainLayout: "+anchuraTotalUtilizada);
  mainLayout.css({'width': anchuraTotalUtilizada + 'px'}); // Reseteo la anchura al 97% del total del documento HTML
  anchuraMainLayout = mainLayout.width();

  leftWidth = $('#leftContainer').width();
  rightWidth = anchuraMainLayout - leftWidth - 20;
  console.log("anchura de la parte de la derecha: "+rightWidth);
  ppalWidth = (rightWidth * 97) / 100;
  console.log("anchura de la ppal: "+ppalWidth);
  $('#rightContainer').css({'width': rightWidth + 'px'});
  $('#ppal_container').css({'width': ppalWidth + 'px'});

  anchuraPosible = ($('#ppal_container').width()) - 16; // Anchura del contenedor de la lista de elementos principales
  javascript:console.log("anchura del ppal: "+anchuraPosible);
  anchuraOffer = ($('.offer:first').width()) + 2; // Anchura de la offer(luego sera la del primer elemento)
  console.log("anchura de una oferta: "+anchuraOffer);

  disparador = anchuraOffer;
  contador = 0;

  while(disparador < anchuraPosible){
   disparador = disparador + anchuraOffer;
   contador = contador + 1
  }

  offersEntran = contador; // Estas son las ofertas que entran el el contenedor principal de elementos
  console.log("ofertas que entran: "+offersEntran);
  margenPorRepartir = anchuraPosible - (anchuraOffer*offersEntran);// El margen que falta por cubrir
  console.log("margen a repartir: "+margenPorRepartir);

  //******************************************************************

  anchuraMainLayout = mainLayout.width();
  margenPorRepartirPorcentual = (margenPorRepartir * 100) / anchuraTotalPagina;
  console.log("margen a repartir porcentual: "+margenPorRepartirPorcentual);

  anchuraMainLayoutRecalculada = 97 - margenPorRepartirPorcentual;
  console.log("anchura del mainLayout porcentual recalculada: "+anchuraMainLayoutRecalculada);

  // dividendo%divisor nos da el resto
  ofertasHay = $('.offer').length;
  ofertasParaCompletarLinea = offersEntran - ofertasHay;
  javascript:console.log("ofertas que hay: "+ofertasHay);
  javascript:console.log("ofertas que faltan para completar la linea: " +ofertasParaCompletarLinea);


  if((ofertasHay > 0) && (margenPorRepartir > 0))  {
    javascript:console.log("entra");
    mainLayout.css({'width': anchuraMainLayoutRecalculada + '%'});
    anchuraMainLayout = $('.mainlayout').width();//reinicio el selector

    leftWidth = $('#leftContainer').width();
    rightWidth = anchuraMainLayout - leftWidth - 20;

    $('#rightContainer').css({'width': rightWidth + 'px'});
  }

  $('#ppal_container').show();

}