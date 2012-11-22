$(document).ready(function() {
  
  $('#new-petition').click(function(e){
      e.preventDefault();

      $('#new-petition-form').modal({
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