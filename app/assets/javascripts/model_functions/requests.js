function expandRequestContainer(){
  //alert("expandRequestContainer funcionando");

  var alturaUserSide = $('#user-side').height();
  var alturaUserReputation = $('#user_reputation_container').height();
  var alturaUserData = $('#user_data_container').height();
  var alturaRequesContainer = alturaUserSide - alturaUserReputation  - alturaUserData -67;
  $('#user_request_list').css('height', alturaRequesContainer);
}


function activateRequestButtons(){
  $('#request_list_container').on('mouseover mouseout','.request', function(event) {
    if (event.type == 'mouseover') {
      $(this).find('.options_menu').removeClass("hidden_container");
    } else {
      $(this).find('.options_menu').addClass("hidden_container");
    }
  });
}