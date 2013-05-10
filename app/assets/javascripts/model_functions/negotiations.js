function maximizeConversationWidth(){
  var maxWidth = $("#ppal_container").width();
  var proposalWidth = $('.negotiation_offer:first').width();
  var conversationWidth = maxWidth - proposalWidth -2; // le quito 2 por no consultar el ancho del borde de la negociacion
  $('.dialog_container').css({'width': conversationWidth + 'px'});
}

function maximizeConversationsHeights(){
  $("[id^=negotiation]").each(function(){
    $(this).equalHeightColumns({children:':not(h2,p)'});
  });
  $("[id^=conversationofnegotiation]").each(function(){
    $(this).css({'height':($(this).parent().height()-57)+'px'});
  });
}


function activateNegotiationButtons(){
  $('.negotiation').hover(
     function () {
        $(this).find('.btn').removeClass("disabled");
     },
     function () {
        $(this).find('.btn').addClass("disabled");
     }
  );
}


// Funcion completa para editar una propuesta
function editProposalScript(){

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
    //alert("Añadir thing al sumario");
    var container = summary_container_selector(t);
    var id = thing.attr("thing_id"); 
    isThingInOffer(container, id) ? sum1ToThing(thing,t,u) : addThingToSummary(thing,t,u);
  }

  function isThingInOffer(container, id){
    //alert("esta la cosa en el sumario?");
    if ( ($(""+container+" > div[thing_id='"+id+"']").length > 0) || ($(""+container+" > .destroy_input[destroy_product_thing_id='"+id+"']").length > 0) ) {
      return true;
    } else {
      return false
    }
  }


  //**************** funcion que añade 1 mas al valor de la cosa elegida cuando ya estaba en la oferta y sus helpers ********************************************//

  function sum1ToThing(thing,t,u){
    //alert("si esta, lanzando funciones de suma");

    var container = summary_container_selector(t);
    var id = thing.attr("thing_id");

    if (hasDestroyInput(container,id)){
      addThingToSummary(thing,t,u);
      deleteDestroyInput(container,id);      
    } else {
      var value = thingQuantityValue(container,id);// Lo cojo aqui por optimizacion, sino deberia acceder 2 veces, una por cada funcion
      //alert(value);
      add1toQuantityContainer(id, container , value);
      add1toQuantityInput(container, id, value);
    }
  }

  function hasDestroyInput(container,id){
    //alert("tiene un input destroy?");

    var cuantos = $(""+container+" > .destroy_input[destroy_product_thing_id='"+id+"']").length;
    if (cuantos > 0) {return true;} else{return false;}
  }

  function deleteDestroyInput(container,id){
    //alert("borrando el input destroy");

    $(""+container+" > .destroy_input[destroy_product_thing_id='"+id+"']").remove();
  }

  function thingQuantityValue(container,id){
    //alert("que cantidad tiene la cosa en el sumario?");

    var result = parseInt(($(""+container+" > div[thing_id='"+id+"'] > .quantity_container")).html(), 10);
    return result;
  }

  function add1toQuantityContainer(id, container,value){
    //alert("añadiendo 1 mas en el quantity container, y ahora tiene que tener...");

    //alert(value+1);
    $(""+container+" div[thing_id='"+id+"'] .quantity_container").html(value+1);
  }

  function add1toQuantityInput(container, id, value){
    //alert("añadiendo 1 mas en el input");

    $(""+container+" > div[thing_id='"+id+"'] > .data_input > input[thing_id='"+id+"']").attr('value', (value +1 ));
  }

  function summary_container_selector(containeris){
    //alert("la cosa va al contenedor: "+containeris);

    return "#summary_offer_"+containeris+"_products_container";
  }



  //**************** funcion que añade la cosa elegida al sumario si no estaba... y sus helpers ********************************************//

  function addThingToSummary(thing,t,u){
    //alert("no esta, lanzando funciones para añadirla");

    var container = summary_container_selector(t);// Cojo ambas aqui por optimizacion, sino deberia acceder al DOM 2 veces, una por cada una de las funciones.
    var thing_id = thing.attr("thing_id");
    addThingViewInSummary(thing, thing_id, container,u);
  }


  function addThingViewInSummary(thing, thing_id, container, user){
    //alert("añandiendola a la vista del sumario");


    var product_id = thing.attr("id");
    var posicion = howMuchInputsAre(container);

    thing.clone()
    .append("<div class='data_input'>"+
      "<input type=\"hidden\" name=\"proposal["+user+"_attributes][products_attributes]["+posicion+"][thing_id]\" value=\""+ thing_id + "\" />" +
      "<input type=\"hidden\" name=\"proposal["+user+"_attributes][products_attributes]["+posicion+"][quantity]\" value=\""+ 1 + "\" thing_id=\""+ thing_id + "\" />" +
      "</div>")
    .prepend('<div class="delete_button">x</div>')
    .addClass("newThing")
    .attr('product_id', thing_id)
    .appendTo(""+container+"")
    .children('.quantity_container')
    .html("1");

    //si tiene destroy input, es porque habia sido eliminada antes del sumario y al volverla a poner, hay que añadirselo
    if (hasDestroyInput(container,thing_id)) {      
      $(""+container+" > div[thing_id='"+thing_id+"'] > .data_input")
      .append("<input type=\"hidden\" name=\"proposal["+user+"_attributes][products_attributes]["+posicion+"][id]\" value=\""+ product_id + "\" />");
    }
  }

  function howMuchInputsAre(container){
    var dataInputs = $(""+container+" > div > .data_input").length;
    var destroyInputs = $(""+container+" > .destroy_input").length;
    var sumDataDestroy = dataInputs + destroyInputs + 1;
    return sumDataDestroy;
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
      deleteFromSummary(thing,t,u,container,owner);
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


  function deleteFromSummary(thing,t,u,container,owner){
    var id = idOfThingInSummary(thing);
    var value = valueOfThingInSummary(thing);
    deleteThingFromSummary(thing);
    
    if (!thing.parent().hasClass("newThing")) {
      addDestroyInput(container,u,id,value,owner);
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

  function addDestroyInput(container,user,id,value, owner){ //hay que meter ambos dentro de un contenedor
    var posicion = howMuchInputsAre(container);

    $(""+container+"").append("<div class='destroy_input' destroy_product_thing_id=\""+ value + "\" product_id=\""+ id + "\">" +
      "<input type=\"hidden\" name=\"proposal["+user+"_attributes][products_attributes]["+posicion+"][id]\" value=\""+ id + "\" />" +
      "<input type=\"hidden\" name=\"proposal["+user+"_attributes][products_attributes]["+posicion+"][_destroy]\" value=\""+ 1 + "\" id=\""+ id + "\" />"+
      "</div>");

    addProductIdToThing(container,value,id,owner);    
  }

  function addProductIdToThing(container,value,id,owner){
    var product_id = $(""+container+" > .destroy_input[destroy_product_thing_id='"+value+"']").attr("product_id");
    $("#"+owner+"_product_container > div[thing_id='"+value+"']").attr('id',product_id);
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
    $('#usuario_dinero').attr("name","proposal[money][nil]").attr("value",0);
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

    //alert("he pulsado sobre uno de sus productos");    

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

    //alert("he pulsado sobre uno de mis productos");
    
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