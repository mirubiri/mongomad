function igualaAlturaUsersideContentside(){
  var alturaVentana = $(document).height()-90;// alturas del footer + header
  if ( ($('#user-side').height()) < alturaVentana ) {
      $('#user-side').css({'height': alturaVentana  + 'px'});
  }
  $('#user-side,#content-side').equalHeightColumns();
}

function maximizaAlturaConversacion(){
  $("[id^=table]").each(function(){
    $(this).equalHeightColumns({children:':not(h2,p)'});
  });
  $("[id^=conversationoftable]").each(function(){
    $(this).css({'height':($(this).parent().height()-57)+'px'});
  });
}

function lineaSeparadoraComentariosPerfil(){
  if ( ($('#comment_list').height()) > ($('#data_list').height()) ) {
      $('#comment_list').css({'border-left': '1px solid rgb(220,220,220)'});
  }else{$('#data_list').css({'border-right': '1px solid rgb(220,220,220)'});}
}

$(window).load(function(){
  ejecutarMasonry();
  maximizaAlturaConversacion();
  igualaAlturaUsersideContentside();
  lineaSeparadoraComentariosPerfil();
});

$(window).bind('resize', function() {
  ejecutarMasonry();
  maximizaAlturaConversacion();
  igualaAlturaUsersideContentside();
});