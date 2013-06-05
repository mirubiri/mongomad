function activateOfferButton(){
  $('.offer').hover(
     function () {
       $(this).find('#negotiate_button').removeClass("disabled");
     },
     function () {
      $(this).find('#negotiate_button').addClass("disabled");
     }
  );
}

function resetPpalPadding(){
  $('#ppal_container').css({'padding-left': '20px'});
  $('#ppal_container').css({'padding-right': '5px'});
}