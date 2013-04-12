function reloadPrincipalContainersHeighs(){
  $('#ppal_container').css({'height': 0  + 'px'});
  $('#user-side').css({'height': 0  + 'px'});
  $('#content-side').css({'height': 0  + 'px'});
}

function matchPrincipalContainersHeighs(){
  // El 90 debe coincidir con las alturas del footer + header
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

function expandRightContainer(){  

  // Aqui empieza el calculo de las anchuras *************************
  mainLayout = $('.mainlayout');
  anchuraPosible = ($('#ppal_container').width()) - 16;
  anchuraOffer = ($('.offer:first').width()) + 2;  
  disparador = anchuraOffer;
  contador = 1;
  offersEntran = 0;

  while(disparador < anchuraPosible){
     disparador = disparador + disparador;
     contador = contador + 1;
  }

  offersEntran = contador;
  margenPorRepartir = anchuraPosible - (anchuraOffer*offersEntran);
  //alert(margenPorRepartir);
  //******************************************************************

  anchuraMainLayout = mainLayout.width();
  //alert(anchuraMainLayout);
  margenPorRepartirPorcentual = (margenPorRepartir * 100) / anchuraMainLayout;
  //alert(margenPorRepartirPorcentual);

  anchuraMainLayoutRecalculada = 97 - margenPorRepartirPorcentual;
  //alert(anchuraMainLayoutRecalculada);

  if(anchuraOffer > 10){
    mainLayout.css({'width': anchuraMainLayoutRecalculada + '%'});
    anchuraMainLayout = $('.mainlayout').width();//reinicio el selector

    leftWidth = $('#leftContainer').width();
    rightWidth = anchuraMainLayout - leftWidth - 20;

    $('#rightContainer').css({'width': rightWidth + 'px'});
  }
  else{
    anchuraMainLayout = $('.mainlayout').width();//reinicio el selector
    leftWidth = $('#leftContainer').width();
    rightWidth = anchuraMainLayout - leftWidth - 20;

    $('#rightContainer').css({'width': rightWidth + 'px'});
  }

}