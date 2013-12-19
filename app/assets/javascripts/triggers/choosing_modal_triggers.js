
function loadModalScripts(){

  //alert("carga el script de la modal");
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



  $('#receiver_content_area').on('click','.item',function(e){

    //$(this).addToOffer("#summary_offer_received_products_container");

    var item = $(this);

    if ( have_stock(item) ) {

      itemAddition("received","receiver",item);
      deduct_1_to_item(item);

    }
    else {
      alert("No queda stock");
    }

  });





  $('#composer_content_area').on('click','.item',function(e){

    var item = $(this);

    if ( have_stock(item) ) {

      itemAddition("given","composer",item);
      deduct_1_to_item(item);

    }
    else {
      alert("No queda stock");
    }

  });




  $('#summary_offer_received_products_container').on('click','.delete_button',function(e){
    itemSubtraction("his","received","receiver",$(this));
  });

  $('#summary_offer_given_products_container').on('click','.delete_button',function(e){
    itemSubtraction("my","given","composer",$(this));
  });

  $('#dineroPidesBotonAgregar').on('click',function(e){
    e.preventDefault();
    addMoneyToSumary("Pides","Ofreces","receiver");
  });

  $('#dineroOfrecesBotonAgregar').on('click',function(e){
    e.preventDefault();
    addMoneyToSumary("Ofreces","Pides","receiver");
  });

  $('#dineroPidesEnSumario a').on('click',function(e){
    e.preventDefault();
    deleteMoneySumary("Ofreces",$(this));
  });

  $('#dineroOfrecesEnSumario a').on('click',function(e){
    e.preventDefault();
    deleteMoneySumary("Pides",$(this));
  });

}
