function maximizeConversationWidth(){
  //alert("maximizeConversationWidth funcionando");

  var maxWidth = $("#ppal_container").width();
  var proposalWidth = $('.negotiation_offer:first').width();
  var conversationWidth = maxWidth - proposalWidth -2; // le quito 2 por no consultar el ancho del borde de la negociacion
  $('.dialog_container').css({'width': conversationWidth + 'px'});
  $('#ppal_container').css({'padding-left': '15px'});
  $('#ppal_container').css({'padding-right': '15px'});
}

function maximizeConversationsHeights(){
  //alert("maximizeConversationsHeights funcionando");

  $("[id^=negotiation]").each(function(){
    $(this).equalHeightColumns({children:':not(h2,p)'});
  });
  $("[id^=conversationofnegotiation]").each(function(){
    $(this).css({'height':($(this).parent().height()-57)+'px'});
    //$(this).css({'max-height':($(this).parent().height()-57)+'px'});
  });
}

function activateNegotiationButtons(){
  //alert("activateNegotiationButtons funcionando");

  $('.negotiation').hover(
     function () {
        $(this).find('.btn').removeClass("disabled");
     },
     function () {
        $(this).find('.btn').addClass("disabled");
     }
  );
}

function reloadDialogContainerWidth(){
  var anchuraTotal = $('.negotiation').first().width();
  var anchuraOfferSide = $('.negotiation > .negotiation_offer').first().width();
  var anchuraDialog = anchuraTotal - anchuraOfferSide;
  $('.negotiation > .dialog_container').css({'width': anchuraDialog +'px'});
}