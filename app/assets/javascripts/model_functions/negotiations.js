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
    var alturaOferta = $(this).find(".negotiation_offer").outerHeight(true);
    $(this).css({'max-height': (alturaOferta + 2) +'px'});
    $(this).find(".dialog_container").css({'height': (alturaOferta) +'px'}).css({'max-height': (alturaOferta) +'px'});
  });
  $("[id^=conversationofnegotiation]").each(function(){
    $(this).css({'height':($(this).parent().height()-57)+'px'});
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


function focusNegotiationWritebox(){
  $(".negotiation").on('click', function() {
    $(this).find("input").focus();
  });

  $(".negotiation").find("input").keypress(function(e){
    if((e.keyCode || e.which) == 13) { //Enter keycode
      //alert("pulsacion de enter");
      $(this).focus();
    }
  });
}

function scrollConversation(){
  $(".negotiation > .dialog_container > .conversation").scrollTop($(this).height());
}