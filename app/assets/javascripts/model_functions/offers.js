function newOfferScript(){

  //Seleccion de usuario

  function userSelection(a,b){
    enableUserSelected(a);
    disableUserSelected(b);
  }

  function enableUserSelected(user){
    $("#"+user+"_selector_area").addClass("user_selected");
    $("#"+user+"_products_container").removeClass("container_invisible");
  }

  function disableUserSelected(user){
    $("#"+user+"_selector_area").removeClass("user_selected");
    $("#"+user+"_products_container").addClass("container_invisible");
  }

  // Añade la thing al sumario
  function thingAddition(t, u, thing){
    var container = summary_container_selector(t);
    var id = thing.attr("thing_id"); 
    isThingInOffer(container, id) ? sum1ToThing(thing,t,u) : addThingToSummary(thing,t,u);
  }

  function isThingInOffer(container, id){
    if ( ($(""+container+" > div[thing_id='"+id+"']").length > 0) || ($(""+container+" > .destroy_input[destroy_product_thing_id='"+id+"']").length > 0) ) {
      return true;
    } else {
      return false
    }
  }


  //**************** funcion que añade 1 mas al valor de la cosa elegida cuando ya estaba en la oferta y sus helpers ********************************************//

  function sum1ToThing(thing,t,u){
    var container = summary_container_selector(t);
    var id = thing.attr("thing_id");

    if (hasDestroyInput(container,id)){
      deleteDestroyInput(container,id);
      addThingToSummary(thing,t,u);
    } else {
      var value = thingQuantityValue(container,id);// Lo cojo aqui por optimizacion, sino deberia acceder 2 veces, una por cada funcion
      add1toQuantityContainer(id, container , value);
      add1toQuantityInput(container, id, value);
    }
  }

  function hasDestroyInput(container,id){
    var cuantos = $(""+container+" > .destroy_input[destroy_product_thing_id='"+id+"']").length;
    if (cuantos > 0) {return true;} else{return false;}
  }

  function deleteDestroyInput(container,id){
    $(""+container+" > .destroy_input[destroy_product_thing_id='"+id+"']").remove();
  }

  function thingQuantityValue(container,id){
    var result = parseInt(($(""+container+" > div[thing_id='"+id+"'] > .quantity_container")).html(), 10);
    return result;
  }

  function add1toQuantityContainer(id, container,value){
    $(""+container+" div[thing_id='"+id+"'] .quantity_container").html(value+1);
  }

  function add1toQuantityInput(container, id, value){
    $(""+container+" > div[thing_id='"+id+"'] > .data_input > input[thing_id='"+id+"']").attr('value', (value +1 ));
  }

  function summary_container_selector(containeris){
    return "#summary_offer_"+containeris+"_products_container";
  }



  //**************** funcion que añade la cosa elegida al sumario si no estaba... y sus helpers ********************************************//

  function addThingToSummary(thing,t,u){
    var container = summary_container_selector(t);// Cojo ambas aqui por optimizacion, sino deberia acceder al DOM 2 veces, una por cada una de las funciones.
    var thing_id = thing.attr("thing_id");
    addThingViewInSummary(thing, thing_id, container,u);
  }


  function addThingViewInSummary(thing, thing_id, container, user){
    thing.clone()
    .append("<div>"+
      "<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][thing_id]\" value=\""+ thing_id + "\" />" +
      "<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][quantity]\" value=\""+ 1 + "\" id=\""+ thing_id + "\" />" +
      "</div>")
    .prepend('<div class="delete_button">x</div>')
    .addClass("newThing")
    .attr('product_id', thing_id)
    .appendTo(""+container+"")
    .children('.quantity_container')
    .html("1");
  }


  // Funcion que quita 1 al stock de la cosa del usuario
  function deduct_1_to_thing(thing){
    var prdStock = stockOfThing(thing);
    thing.children('.quantity_container').html(prdStock - 1);
    thing.attr('stock',(prdStock-1));
  }


  function stockOfThing(thing){
    var result = parseInt(thing.attr('stock'), 10);
    return result;
  }


  function have_stock(thing){
    var prdStock = parseInt(thing.attr('stock'), 10);
    if (prdStock > 0) { return true; } else { return false; }
  }


  //**************** funcion que elimina la cosa del sumario y sus helpers ********************************************//

  function thingSubtraction(owner,t,u,thing){
    var container = summary_container_selector(t); // Lo cojo qui por optimizacion, sino deberia acceder al DOM 2 veces, una por cada una de las funciones.
    var id = thing.parent().attr("thing_id");

    if (have_more_than_one(container, id)){
      deduct1ToProduct(container, id);
    }
    else{
      deleteFromSummary(thing,t,u,container);
    }
    sum1ToThingStock(thing,owner,id);
  }


  function have_more_than_one(container, id){
    var prdQty = productQuantity(container, id);
    if (prdQty > 1) {return true;} else{return false;}
  }

  function deduct1ToProduct(container, id){
    var prdQty = productQuantity(container, id);
    $(""+container+" > div[thing_id='"+id+"'] .quantity_container").html(prdQty-1);
    $(""+container+" > div[thing_id='"+id+"'] > .data_input > input[thing_id='"+id+"']").attr('value',(prdQty-1));
  }


  function productQuantity(container, id){ 
    var result = parseInt(($(""+container+" > div[thing_id='"+id+"'] > .quantity_container")).html(), 10);
    return result;
  }


  function deleteFromSummary(thing,t,u,container){
    var id = idOfThingInSummary(thing);
    var value = valueOfThingInSummary(thing);
    deleteThingFromSummary(thing);
    
    if (!thing.parent().hasClass("newThing")) {
      addDestroyInput(container,u,id,value);
    }
  }

  function idOfThingInSummary(thing){
    var result = thing.parent().attr("product_id");
    return result;
  }

  function valueOfThingInSummary(thing){
    var result = thing.parent().attr("thing_id");
    return result;
  }

  function deleteThingFromSummary(thing){
    thing.parent().remove();
  }  

  function addDestroyInput(container,user,id,value){ //hay que meter ambos dentro de un contenedor
    $(""+container+"").append("<div class='destroy_input' destroy_product_thing_id=\""+ value + "\" product_id=\""+ id + "\">" +
      "<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][_id]\" value=\""+ id + "\" />" +
      "<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][_destroy]\" value=\""+ 1 + "\" id=\""+ id + "\" />"+
      "</div>");
  }

  function sum1ToThingStock(thing,owner, id){
    var hpQty = thingStockFromProductList(owner, id);
    $("#"+owner+"_product_container > div[thing_id='"+id+"']").attr('stock',(hpQty + 1));
  }

  function thingStockFromProductList(user, id){
    var result = parseInt($("#"+user+"_product_container div[thing_id='"+id+"']").attr('stock'),10);
    return result;
  }

  // ************** Funcion que añade el dinero rellenado al sumario de la oferta, y sus helpers *******************
  function addMoneyToSumary(a1,a2,u){
    putsQuantityWriteInOffer(a1);
    disableMoneySentButton(a2);
    putsKindOfUserInSummary(u);
    pustUserMoneyQuantityInSummary(a1);
    resetMoneySelector(a1);
  }

  function putsQuantityWriteInOffer(user){
    $("#dinero"+user+"EnSumario").empty().append($.trim($("#dinero"+user+"").val())).append('<a href="#blank">x</a>');
  }

  function disableMoneySentButton(user){
    $("#dinero"+user+"BotonAgregar").addClass("container_invisible");
  }

  function putsKindOfUserInSummary(kindofuser){
    $('#usuario_id').attr( "value",$("#new_offer_"+kindofuser+"_selector").attr("value"));
  }

  function pustUserMoneyQuantityInSummary(user){
    $('#usuario_dinero').attr("value",$("#dinero"+user+"").val());
  }

  function resetMoneySelector(user){
    $("#dinero"+user+"").val("");
  }

  // ************** Funcion que quita el dinero rellenado al sumario de la oferta, y sus helpers *******************

  function deleteMoneySumary(a,selector){
    emptyMoneySelector(selector);
    enableUserMoneySelector(a);
    resetUserAndQuantityInSummary();
  }

  function emptyMoneySelector(userSelector){
    userSelector.parent().empty();
  }

  function enableUserMoneySelector(user){
    $("#dinero"+user+"BotonAgregar").removeClass("container_invisible");
  }

  function resetUserAndQuantityInSummary(){
    $('#usuario_dinero').attr("name","offer[money][nil]").attr("value",0);
    $('#usuario_id').attr("value",0);
  }

  //Fin funciones de ayuda para la ejecucion de los procesos de nueva oferta



  // disparadores de los productos y things dentro de una oferta

  $('#new_offer_receiver_selector').live('click',function(e){
    e.preventDefault();
    userSelection("receiver","composer");
  });

  $('#new_offer_composer_selector').live('click',function(e){
    e.preventDefault();
    userSelection("composer","receiver");
  });


  $('#his_product_container .product').live('click',function(e){
    var thing = $(this);

    if ( have_stock(thing) ) {

      thingAddition("received","receiver",thing);
      deduct_1_to_thing(thing);

    }
    else {
      alert("No hay stock");
    }
  });


  $('#my_product_container .product').live('click',function(e){
    var thing = $(this);

    if ( have_stock(thing) ) {

      thingAddition("given","composer",thing);
      deduct_1_to_thing(thing);

    }
    else {
      alert("No hay stock");
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
}




function activateOfferButton(){
  $('.offer').hover(
     function () {
       $(this).find('#negotiate_button').removeClass("disabled");
     },
     function () {
      $(this).find('#negotiate_button').addClass("disabled");
     }
  );
}


function setOffersMargin() {
  var anchuraPosible = ($('#ppal_container').width()) - 16;
  var anchuraOffer = ($('.offer:first').width()) + 2;
  var disparador = anchuraOffer;
  var contador = 1;
  var offersEntran = 0;

  while(disparador < anchuraPosible){
     disparador = disparador + disparador;
     contador = contador + 1;
  }

  var offersEntran = contador;

  var anchuraTotalMargen = anchuraPosible - (anchuraOffer * offersEntran);
  var margenesPorRellenar = offersEntran * 2;
  var margenOffer = anchuraTotalMargen / margenesPorRellenar;
  margenOffer = Math.floor(margenOffer);
  var offertasHay = $('.offer').length;

  if(offertasHay > (offersEntran -1)){
    $('.offer').css({'margin': '0px ' + margenOffer + 'px 10px ' + margenOffer + 'px'});

  }else{
    $('.offer').css({'margin': '0px 10px 10px 0px'});
  }

  /*alert(anchuraTotalMargen + " = margen que tengo total en cada fila\n"
        + margenesPorRellenar + " = numero de margenes por rellena en cada fila\n"
        + margenOffer + " = margen calculado para cada oferta\n");*/
}