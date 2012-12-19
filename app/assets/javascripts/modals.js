$(document).ready(function() {
  
  $('#add_request_button').click(function(e){
      e.preventDefault();

      $('#new-request-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

  $('#new-offer-button').click(function(e){
      e.preventDefault();

      $('#new-offer-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

});