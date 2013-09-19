function loadModalScripts(){

  //alert("carga el script de la modal");

  $('#new_offer_receiver_selector').on('click',function(e){
    e.preventDefault();
    userSelection("receiver","composer");
  });

  $('#new_offer_composer_selector').on('click',function(e){
    e.preventDefault();
    userSelection("composer","receiver");
  });


  $('#his_product_container').on('click','.product',function(e){
    var item = $(this);

    if ( have_stock(item) ) {

      itemAddition("received","receiver",item);
      deduct_1_to_item(item);

    }
    else {
      alert("No queda stock");
    }

  });


  $('#my_product_container').on('click','.product',function(e){
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
