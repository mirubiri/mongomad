function reloadPrincipalContainersHeighs(){
  $('#left_container').css({'height': 0  + 'px'});
  $('#right_container').css({'height': 0  + 'px'});
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

  //$('#ppal_container').hide();

  // Pongo los contenedores a sus anchuras iniciales correctas *************************

  mainLayout = $('.mainlayout');
  anchuraTotalPagina = $(document).width();

  anchuraMainLayout = mainLayout.innerWidth();
  console.log("anchura del mainLayout: "+anchuraMainLayout);

  leftWidth = $('#leftContainer').outerWidth( true );
  console.log("anchura del contenedor de la izda: "+leftWidth);
  rightWidth = anchuraMainLayout - leftWidth -2;
  $('#rightContainer').css({'width': rightWidth + 'px'});
  rightWidth = $('#rightContainer').outerWidth( true );
  console.log("anchura del contenedor de la dcha: "+rightWidth);
  contentSideWidth = $('#content-side').outerWidth( true );
  console.log("anchura del content-side: "+contentSideWidth);

  ppalWidth = $('#ppal_container').width();
  console.log("anchura del ppal_container: "+ppalWidth);

  // Ya tengo los contenedores con sus anchuras iniciales correctas, ahora comienzo el calculo de los margenes

  anchuraPosible = ppalWidth;
  console.log("anchura que tenemos para los elementos: "+anchuraPosible);

  anchuraOffer = $('.offer:first').outerWidth( true ); // Anchura de la offer incluidos su unico margen(el derecho)
  console.log("anchura de una oferta: "+anchuraOffer);

  anchuraAculumada = anchuraOffer;
  contador = 0;

  ofertasHay = $('.offer').length;

  if(ofertasHay > 0){
    javascript:console.log("entra en el algoritmo de modificacion");

    while(anchuraAculumada < anchuraPosible){
     anchuraAculumada = anchuraAculumada + anchuraOffer;
     contador = contador + 1
    }

    offersEntran = contador; // Estas son las ofertas que entran el el contenedor principal de elementos
    console.log("ofertas que entran: "+offersEntran);
    margenPorRepartir = anchuraPosible - (anchuraOffer*offersEntran);// El margen que falta por cubrir
    console.log("margen a repartir: "+margenPorRepartir);

    margenPorRepartirPorcentual = (margenPorRepartir * 100) / anchuraTotalPagina;
    console.log("margen a repartir porcentual: "+margenPorRepartirPorcentual);
    anchuraMainLayoutRecalculada = 97 - margenPorRepartirPorcentual;
    console.log("anchura del mainLayout porcentual recalculada: "+anchuraMainLayoutRecalculada);

    javascript:console.log("entra en el algoritmo de modificacion");
    mainLayout.css({'width': anchuraMainLayoutRecalculada + '%'});
    anchuraMainLayout = $('.mainlayout').innerWidth();//reinicio el selector
    console.log("nueva anchura del mainLayout: "+anchuraMainLayout);

    leftWidth = $('#leftContainer').outerWidth( true );
    console.log("nueva anchura del contenedor de la izda: "+leftWidth);
    rightWidth = anchuraMainLayout - leftWidth -2;
    $('#rightContainer').css({'width': rightWidth + 'px'});
    rightWidth = $('#rightContainer').width();
    console.log("nueva anchura del contenedor de la dcha: "+rightWidth);
    contentSideWidth = $('#content-side').outerWidth( true );
    console.log("nueva anchura del content-side: "+contentSideWidth);
    ppalWidth = (contentSideWidth * 97) / 100;
    $('#ppal_container').css({'width': ppalWidth + 'px'});
    ppalWidth = $('#ppal_container').width();
    console.log("nueva nchura del ppal_container: "+ppalWidth);
  }

  //$('#ppal_container').show();

}
