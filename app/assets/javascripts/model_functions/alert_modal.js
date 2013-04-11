function activateAlertButton(){
  $('.user_alert').hover(
     function() {
        $(this).find('#alert_button').removeClass("hidden_container");
     },
     function() {
        $(this).find('#alert_button').addClass("hidden_container");
     }
  );
}