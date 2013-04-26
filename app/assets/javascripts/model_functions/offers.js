function newOfferScript(){
  //Funciones de ayuda para la ejecucion de los procesos de nueva oferta

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


  // Añade la cosa al sumario, exista o no exista, y el helper que nos indica si existe la cosa en el sumario de la oferta
  function thingAddition(t, u, thing){
    thing_in_offer(thing) ? sum1ToThing(thing,t,u) : add_thing_to_summary(thing,t,u);
  }

  function thing_in_offer(thing){
    if ($("input[id='"+thing.attr("id")+"']").length > 0) {
      return true;
    } else {
      return false
    }
  }


  //**************** funcion que añade 1 mas al valor de la cosa elegida y sus helpers ********************************************//

  function sum1ToThing(thing,t,u){
    var container = summary_container_selector(t);
    var id = thing.attr("id");

    if (hasDestroyInput(container,id)) {
      deleteDestroyInput(container,id);
      add_thing_to_summary(thing,t,u);
    } else {
      var value = thingQuantityValue(thing);// Lo cojo aqui por optimizacion, sino deberia acceder 2 veces, una por cada funcion
      add1toQuantityContainer(thing, t, value);
      add1toQuantityInput(thing, value);
    }
  }

  function hasDestroyInput(container,id){
    var cuantos = $(""+container+" > div > input[id='"+id+"']").length;
    if (cuantos > 0) {return true;} else{return false;}
  }

  function deleteDestroyInput(container,id){
    $(""+container+" input[id='"+id+"']").parent().remove();
  }

  function thingQuantityValue(thing){
    var result = parseInt(($("input[id='"+thing.attr("id")+"']")).attr('value'), 10);
    return result;
  }

  function add1toQuantityContainer(thing, container,value){
    var container = summary_container_selector(container);
    $(""+container+" div[id='"+thing.attr("id")+"'] .quantity_container").html(value+1);
  }

  function add1toQuantityInput(thing, value){
    $("input[id='"+thing.attr("id")+"']").attr('value', (value +1 ));
  }

  function summary_container_selector(containeris){
    return "#summary_offer_"+containeris+"_products_container";
  }



  //**************** funcion que añade la cosa elegida al sumario si no estaba y sus helpers ********************************************//

  function add_thing_to_summary(thing,t,u){
    var container = summary_container_selector(t);// Cojo ambas aqui por optimizacion, sino deberia acceder al DOM 2 veces, una por cada una de las funciones.
    var id = thing.attr("id");
    addThingViewInSummary(thing, container);
    addThingInputAttributes(container, u, id);
  }

  function addThingViewInSummary(thing, container){
    thing.clone().prepend('<div class="delete_button">x</div>').appendTo(""+container+"").children('.quantity_container').html("1");
  }

  function addThingInputAttributes(container, user, id){
    $(""+container+"").append("<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][thing_id]\" value=\""+ id + "\" />");
    $(""+container+"").append("<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][quantity]\" value=\""+ 1 + "\" id=\""+ id + "\" />");
  }


  // Funcion que quita 1 al stock de la cosa del usuario
  function deduct_1_to_thing(thing){
    var prdStock = stockOfThing(thing);
    thing.children('.quantity_container').html(prdStock - 1);
    thing.attr('value',(prdStock-1));
  }


  function stockOfThing(thing){
    var result = parseInt(thing.attr('value'), 10);
    return result;
  }


  function have_stock(thing){
    var prdStock = parseInt(thing.attr('value'), 10);
    if (prdStock > 0) { return true; } else { return false; }
  }


  function thingSubtraction(t,u,thing){

    var container = summary_container_selector(t); // Lo cojo qui por optimizacion, sino deberia acceder al DOM 2 veces, una por cada una de las funciones.

    if (have_more_than_one(thing)){
      deduct_1_to_product(thing,t,container);
    }
    else{
      delete_from_summary(thing,t,u,container);
    }
    sum1ToThingStock(thing,u);
  }


  function have_more_than_one(thing){
    var prdQty = productQuantity(thing);
    if (prdQty > 1) {return true;} else{return false;}
  }

  function deduct_1_to_product(thing,t, container){
    var prdQty = productQuantity(thing);
    $(""+container+" div[id='"+thing.parent().attr("id")+"'] .quantity_container").html(prdQty-1);
    $("input[id='"+thing.parent().attr("id")+"']").attr('value',(prdQty-1));
  }


  function productQuantity(product){
    var result = parseInt(($("input[id='"+product.parent().attr("id")+"']")).attr('value'), 10);
    return result;
  }

  function delete_from_summary(thing,t,u,container){
    var id = idOfThingInSummary(thing);
    deleteThingFromSummary(thing);
    deleteThingInputAttributes(container,id);
    addDestroyInput(container,u,id);
  }

  function idOfThingInSummary(thing){
    var result = thing.parent().attr("id");
    return result;
  }

  function deleteThingFromSummary(thing){
    thing.parent().remove();
  }

  function deleteThingInputAttributes(container,id){
    $(""+container+" input[id='"+id+"']").remove();
    $(""+container+" input[value='"+id+"']").remove();
  }

  function addDestroyInput(container,user,id){ // hay que meter ambos dentro de un contenedor
    $(""+container+"").append("<div>"+
      "<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][thing_id]\" value=\""+ id + "\" />" +
      "<input type=\"hidden\" name=\"offer["+user+"_attributes][products_attributes][][_destroy]\" value=\""+ 1 + "\" id=\""+ id + "\" />"+
      "</div>");
  }

  function sum1ToThingStock(thing,u){
    var hpQty = thingStockFromProductSummary(thing,u);
    $("#"+u+"_product_container div[id='"+thing.parent().attr("id")+"']").attr('value',(hpQty + 1));
    $("#"+u+"_product_container div[id='"+thing.parent().attr("id")+"']").children('.quantity_container').html(hpQty +1);
  }

  function thingStockFromProductSummary(thing,user){
    var result = parseInt($("#"+user+"_product_container div[id='"+thing.parent().attr("id")+"']").attr('value'),10);
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
    thingSubtraction("received","receiver",$(this));
  });

  $('#summary_offer_given_products_container > .product > .delete_button').live('click',function(e){
    thingSubtraction("given","composer",$(this));
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