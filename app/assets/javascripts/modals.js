$(document).ready(function() {
  
  $('#new-request').click(function(e){
      e.preventDefault();

      $('#new-request-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

  $('#new-offer').click(function(e){
      e.preventDefault();

      $('#new-offer-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

});