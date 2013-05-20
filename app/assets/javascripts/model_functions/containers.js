function resetContainers(){
  expandContainers();
  matchPrincipalContainersHeighs();
}


function matchPrincipalContainersHeighs(){
  //alert("matchPrincipalContainersHeighs funcionando");
  
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
  //alert("expandContainers funcionando");

  setRightContainerWidth();
  adjustPpalElements();
}


function setRightContainerWidth(){

  var anchuraMainLayout = $('.mainlayout').innerWidth();
  console.log("anchura del mainLayout: "+anchuraMainLayout);

  var leftWidth = $('#leftContainer').outerWidth( true );
  console.log("anchura del contenedor de la izda: "+leftWidth); 

  var rightWidth = anchuraMainLayout - leftWidth -2;
  console.log("calculo para la nueva anchura del right_container: "+rightWidth);
  $('#rightContainer').css({'width': rightWidth + 'px'});

  rightWidth = $('#rightContainer').width();
  console.log("anchura del contenedor de la dcha: "+rightWidth);  

  contentSideWidth = $('#content-side').width();
  console.log("anchura del content-side: "+ contentSideWidth);

}


function adjustPpalElements(){
  var anchuraPosible = ($('#ppal_container').width()) - 16;

  if($("#ppal_container div:first-child").length > 0) {

    var anchuraPrincipalElement = $("#ppal_container div:first-child").outerWidth( true );
    var firstChildClass = $("#ppal_container div:first-child").attr('class').split(" ")[0];
    var numOfChildren = $("."+firstChildClass+"").length;

    if( anchuraPrincipalElement > 20 ){   

      console.log("anchura del elemento principal: "+anchuraPrincipalElement);

      var disparador = anchuraPrincipalElement;
      var contador = 1;
      var elementosEntran = 0;

      while(disparador < anchuraPosible){
         disparador = disparador + disparador;
         contador = contador + 1;
      }

      var elementosEntran = contador;
      console.log("¿cuantas ofertan entran?: "+elementosEntran);

      if( ((numOfChildren%elementosEntran) > 0) && ( numOfChildren>elementosEntran ) ) {

        var anchuraQueQuitar = anchuraPosible - (anchuraPrincipalElement * elementosEntran);
        console.log("anchura que quitar: "+anchuraQueQuitar);  

        if( anchuraQueQuitar > 0 ){
          var rightContainer = $('#rightContainer');
          var rightContainerWidth = rightContainer.width();
          var finalRightContainerWidth = rightContainerWidth - anchuraQueQuitar;

          $('#rightContainer').css({'width': finalRightContainerWidth  + 'px'});
          centerAlignToContainers(anchuraQueQuitar);
        }

      }

    }else{
      console.log("anchura del elemento principal no llega al minimo pq es: "+anchuraPrincipalElement);
    }

  } 

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