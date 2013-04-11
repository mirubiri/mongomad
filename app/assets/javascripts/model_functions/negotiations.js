



function maximizeConversationsHeights(){
  $("[id^=negotiation]").each(function(){
    $(this).equalHeightColumns({children:':not(h2,p)'});
  });
  $("[id^=conversationofnegotiation]").each(function(){
    $(this).css({'height':($(this).parent().height()-57)+'px'});
  });
}




function activateNegotiationButtons(){
  $('.negotiation').hover(
     function () {
        $(this).find('.btn').removeClass("disabled");
     },
     function () {
        $(this).find('.btn').addClass("disabled");
     }
  );
}