function loadModalScripts(){

  alert("carga el script de la modal");

  $('#new_offer_receiver_selector').on('click',function(e){
    e.preventDefault();
    userSelection("receiver","composer");
  });

  $('#new_offer_composer_selector').on('click',function(e){
    e.preventDefault();
    userSelection("composer","receiver");
  });


  $('#his_product_container').on('click','.product',function(e){
    var thing = $(this);

    if ( have_stock(thing) ) {

      thingAddition("received","receiver",thing);
      deduct_1_to_thing(thing);

    }
    else {
      alert("No queda stock");
    }

  });


  $('#my_product_container').on('click','.product',function(e){
    var thing = $(this);

    if ( have_stock(thing) ) {

      thingAddition("given","composer",thing);
      deduct_1_to_thing(thing);

    }
    else {
      alert("No queda stock");
    }

  });


  $('#summary_offer_received_products_container').on('click','.delete_button',function(e){
    thingSubtraction("his","received","receiver",$(this));
  });

  $('#summary_offer_given_products_container').on('click','.delete_button',function(e){
    thingSubtraction("my","given","composer",$(this));
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
