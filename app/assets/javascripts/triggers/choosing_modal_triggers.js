$('#new_offer_receiver_selector').live('click',function(e){
  e.preventDefault();
  userSelection("receiver","composer");
});

$('#new_offer_composer_selector').live('click',function(e){
  e.preventDefault();
  userSelection("composer","receiver");
});

$('#his_product_container > .product').live('click',function(e){

  //alert("he pulsado sobre uno de sus productos"); 

  var thing = $(this);

  if ( have_stock(thing) ) {

    thingAddition("received","receiver",thing);
    deduct_1_to_thing(thing);

  }
  else {
    //alert("No hay stock");
  }    

});  

$('#my_product_container > .product').live('click',function(e){

  //alert("he pulsado sobre uno de mis productos");

  var thing = $(this);

  if ( have_stock(thing) ) {

    thingAddition("given","composer",thing);
    deduct_1_to_thing(thing);

  }
  else {
    //alert("No hay stock");
  }
  
});


$('#summary_offer_received_products_container > .product > .delete_button').live('click',function(e){
  thingSubtraction("his","received","receiver",$(this));
});

$('#summary_offer_given_products_container > .product > .delete_button').live('click',function(e){
  thingSubtraction("my","given","composer",$(this));
});

$('#dineroPidesBotonAgregar').live('click',function(e){
  e.preventDefault();
  addMoneyToSumary("Pides","Ofreces","receiver");
});

$('#dineroOfrecesBotonAgregar').live('click',function(e){
  e.preventDefault();
  addMoneyToSumary("Ofreces","Pides","receiver");
});

$('#dineroPidesEnSumario a').live('click',function(e){
  e.preventDefault();
  deleteMoneySumary("Ofreces",$(this));
});

$('#dineroOfrecesEnSumario a').live('click',function(e){
  e.preventDefault();
  deleteMoneySumary("Pides",$(this));
});