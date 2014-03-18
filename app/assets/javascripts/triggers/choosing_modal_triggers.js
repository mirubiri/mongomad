
function loadOfferModalScripts(){

  //alert("entro en juego");

  if ($('#new-offer-form').length){
    //alert("carga el script de la modal de new");
    $('#new-offer-form').firstUserSelected();

    $('#new_offer_receiver_selector').on('click',function(e){
      e.preventDefault();
      $('#new-offer-form').userSelection("receiver","composer","message");
    });

    $('#new_offer_composer_selector').on('click',function(e){
      e.preventDefault();
      $('#new-offer-form').userSelection("composer","receiver","message");
    });

    $('#new_message_selector').on('click',function(e){
      e.preventDefault();
      $('#new-offer-form').userSelection("message","composer","receiver");
    });
  }


  if ($('#edit-offer-form').length){
    //alert("carga el script de la modal de edit");
    $('#edit-offer-form').firstUserSelected();

    $('#new_offer_receiver_selector').on('click',function(e){
      e.preventDefault();
      $('#edit-offer-form').userSelection("receiver","composer","message");
    });

    $('#new_offer_composer_selector').on('click',function(e){
      e.preventDefault();
      $('#edit-offer-form').userSelection("composer","receiver","message");
    });

    $('#new_message_selector').on('click',function(e){
      e.preventDefault();
      $('#edit-offer-form').userSelection("message","composer","receiver");
    });
  }


  if ($('#edit-negotiation-form').length){
    //alert("carga el script de la modal de edit");
    $('#edit-negotiation-form').firstUserSelected();

    $('#new_offer_receiver_selector').on('click',function(e){
      e.preventDefault();
      $('#edit-negotiation-form').userSelection("receiver","composer","message");
    });

    $('#new_offer_composer_selector').on('click',function(e){
      e.preventDefault();
      $('#edit-negotiation-form').userSelection("composer","receiver","message");
    });

    $('#new_message_selector').on('click',function(e){
      e.preventDefault();
      $('#edit-negotiation-form').userSelection("message","composer","receiver");
    });
  }

  $('#products_list').on('click','img',function(e){
    var padre  = $(this).parent().parent();
    padre.addProductToSummary();
    if (padre.attr("type") == "Cash"){
      $('#products_list').find("[type=Cash]").append('<div class="offer_artistic_layer"></div>');
    }else{
      padre.append('<div class="offer_artistic_layer"></div>');
    }

  });

  $('#offer_summary').on('click','img',function(e){
    var padre  = $(this).parent().parent();
    if (padre.attr("type") == "Cash"){
      $('#products_list').find("[type=Cash]").find('.offer_artistic_layer').remove();
    }
    padre.removeProductFromSummary();
  });

}
