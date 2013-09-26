//Seleccion de usuario

function firstUserSelected(){
  $(".user_image").first().children(":first").css('box-shadow','0px 3px 5px red, 0px -3px 5px red');
}

function userSelection(a,b,c){
  $("#composer_content_area").removeClass('hidden_container');
  $("#message_content_area").removeClass('hidden_container');
  enableUserSelected(a);
  disableUserSelected(b);
  disableUserSelected(c);
}

function enableUserSelected(user){
  $("#"+user+"_selector_area").children(":first").children(":first").css('box-shadow','0px 3px 5px red, 0px -3px 5px red');
  $("#"+user+"_products_container").removeClass("container_invisible");
  $("#"+user+"_content_area").show();
}

function disableUserSelected(user){
  $("#"+user+"_selector_area").children(":first").children(":first").css('box-shadow','0px 3px 5px #888, 0px -3px 5px #888');
  $("#"+user+"_products_container").addClass("container_invisible");
  $("#"+user+"_content_area").hide();
}

function getElementModifiedClass(){
  var clase = $('#ppal_container').children('div:first').attr('class');

  if (clase === "negotiation"){
    return "proposal";
  }
  else{
    return "offer";
  }
}

function paint_overmoused_image(id){
  //$("#overview_image").load(<%=  %>);
}

// Añade la item al sumario
function itemAddition(t, u, item){
  //alert("Añadir item al sumario");
  var container = summary_container_selector(t);
  var id = item.attr("item_id");
  isitemInOffer(container, id) ? sum1Toitem(item,t,u) : additemToSummary(item,t,u);
}

function isitemInOffer(container, id){
  //alert("esta la cosa en el sumario?");
  if ( ($(""+container+" > div[item_id='"+id+"']").length > 0) || ($(""+container+" > .destroy_input[destroy_product_item_id='"+id+"']").length > 0) ) {
    return true;
  } else {
    return false;
  }
}


//**************** funcion que añade 1 mas al valor de la cosa elegida cuando ya estaba en la oferta y sus helpers ********************************************//

function sum1Toitem(item,t,u){
  //alert("si esta, lanzando funciones de suma");

  var container = summary_container_selector(t);
  var id = item.attr("item_id");

  if (hasDestroyInput(container,id)){
    additemToSummary(item,t,u);
    deleteDestroyInput(container,id);
  } else {
    var value = itemQuantityValue(container,id);// Lo cojo aqui por optimizacion, sino deberia acceder 2 veces, una por cada funcion
    //alert(value);
    add1toQuantityContainer(id, container , value);
    add1toQuantityInput(container, id, value);
  }
}

function hasDestroyInput(container,id){
  //alert("tiene un input destroy?");

  var cuantos = $(""+container+" > .destroy_input[destroy_product_item_id='"+id+"']").length;
  if (cuantos > 0) {return true;} else{return false;}
}

function deleteDestroyInput(container,id){
  //alert("borrando el input destroy");

  $(""+container+" > .destroy_input[destroy_product_item_id='"+id+"']").remove();
}

function itemQuantityValue(container,id){
  //alert("que cantidad tiene la cosa en el sumario?");

  var result = parseInt(($(""+container+" > div[item_id='"+id+"'] > .quantity_container")).html(), 10);
  return result;
}

function add1toQuantityContainer(id, container,value){
  //alert("añadiendo 1 mas en el quantity container, y ahora tiene que tener...");

  //alert(value+1);
  $(""+container+" div[item_id='"+id+"'] .quantity_container").html(value+1);
}

function add1toQuantityInput(container, id, value){
  //alert("añadiendo 1 mas en el input");

  $(""+container+" > div[item_id='"+id+"'] > .data_input > input[item_id='"+id+"']").attr('value', (value +1 ));
}

function summary_container_selector(containeris){
  //alert("la cosa va al contenedor: "+containeris);

  return "#summary_offer_"+containeris+"_products_container";
}



//**************** funcion que añade la cosa elegida al sumario si no estaba... y sus helpers ********************************************//

function additemToSummary(item,t,u){
  //alert("no esta, lanzando funciones para añadirla");

  var container = summary_container_selector(t);// Cojo ambas aqui por optimizacion, sino deberia acceder al DOM 2 veces, una por cada una de las funciones.
  var item_id = item.attr("item_id");
  additemViewInSummary(item, item_id, container,u);
}


function additemViewInSummary(item, item_id, container, user){
  //alert("añandiendola a la vista del sumario");

  var product_id = item.attr("id");
  var posicion = howMuchInputsAre(container);
  var tipoElemento = getElementModifiedClass();

  //alert(tipoElemento);

  item.clone()
  .append("<div class='data_input'>"+
    "<input type=\"hidden\" name=\""+tipoElemento+"["+user+"_attributes][products_attributes]["+posicion+"][item_id]\" value=\""+ item_id + "\" />" +
    "<input type=\"hidden\" name=\""+tipoElemento+"["+user+"_attributes][products_attributes]["+posicion+"][quantity]\" value=\""+ 1 + "\" item_id=\""+ item_id + "\" />" +
    "</div>")
  .prepend('<div class="delete_button">x</div>')
  .addClass("newitem")
  .attr('product_id', item_id)
  .appendTo(""+container+"")
  .children('.quantity_container')
  .html("1");

  //si tiene destroy input, es porque habia sido eliminada antes del sumario y al volverla a poner, hay que añadirselo
  if (hasDestroyInput(container,item_id)) {
    $(""+container+" > div[item_id='"+item_id+"'] > .data_input")
    .append("<input type=\"hidden\" name=\""+tipoElemento+"["+user+"_attributes][products_attributes]["+posicion+"][id]\" value=\""+ product_id + "\" />");
  }
}

function howMuchInputsAre(container){
  var dataInputs = $(""+container+" > div > .data_input").length;
  var destroyInputs = $(""+container+" > .destroy_input").length;
  var sumDataDestroy = dataInputs + destroyInputs + 1;
  return sumDataDestroy;
}


// Funcion que quita 1 al stock de la cosa del usuario
function deduct_1_to_item(item){
  var prdStock = stockOfitem(item);
  item.children('.quantity_container').html(prdStock - 1);
  item.attr('stock',(prdStock-1));
}


function stockOfitem(item){
  var result = parseInt(item.attr('stock'), 10);
  return result;
}


function have_stock(item){
  var prdStock = parseInt(item.attr('stock'), 10);
  if (prdStock > 0) { return true; } else { return false; }
}


//**************** funcion que elimina la cosa del sumario y sus helpers ********************************************//

function itemSubtraction(owner,t,u,item){
  var container = summary_container_selector(t); // Lo cojo qui por optimizacion, sino deberia acceder al DOM 2 veces, una por cada una de las funciones.
  var id = item.parent().attr("item_id");

  if (have_more_than_one(container, id)){
    deduct1ToProduct(container, id);
  }
  else{
    deleteFromSummary(item,t,u,container,owner);
  }
  sum1ToitemStock(item,owner,id);
}


function have_more_than_one(container, id){
  var prdQty = productQuantity(container, id);
  if (prdQty > 1) {return true;} else{return false;}
}

function deduct1ToProduct(container, id){
  var prdQty = productQuantity(container, id);
  $(""+container+" > div[item_id='"+id+"'] .quantity_container").html(prdQty-1);
  $(""+container+" > div[item_id='"+id+"'] > .data_input > input[item_id='"+id+"']").attr('value',(prdQty-1));
}


function productQuantity(container, id){
  var result = parseInt(($(""+container+" > div[item_id='"+id+"'] > .quantity_container")).html(), 10);
  return result;
}


function deleteFromSummary(item,t,u,container,owner){
  var id = idOfitemInSummary(item);
  var value = valueOfitemInSummary(item);
  deleteitemFromSummary(item);

  if (!item.parent().hasClass("newitem")) {
    addDestroyInput(container,u,id,value,owner);
  }
}

function idOfitemInSummary(item){
  var result = item.parent().attr("product_id");
  return result;
}

function valueOfitemInSummary(item){
  var result = item.parent().attr("item_id");
  return result;
}

function deleteitemFromSummary(item){
  item.parent().remove();
}

function addDestroyInput(container,user,id,value, owner){ //hay que meter ambos dentro de un contenedor
  var posicion = howMuchInputsAre(container);
  var tipoElemento = getElementModifiedClass();

  if(isOffer()===true){
    $(""+container+"").append("<div class='destroy_input' destroy_product_item_id=\""+ value + "\" product_id=\""+ id + "\">" +
      "<input type=\"hidden\" name=\""+tipoElemento+"["+user+"_attributes][products_attributes]["+posicion+"][id]\" value=\""+ id + "\" />" +
      "<input type=\"hidden\" name=\""+tipoElemento+"["+user+"_attributes][products_attributes]["+posicion+"][_destroy]\" value=\""+ 1 + "\" id=\""+ id + "\" />"+
      "</div>");
  }

  addProductIdToitem(container,value,id,owner);
}

function addProductIdToitem(container,value,id,owner){
  var product_id = $(""+container+" > .destroy_input[destroy_product_item_id='"+value+"']").attr("product_id");
  $("#"+owner+"_product_container > div[item_id='"+value+"']").attr('id',product_id);
}

function sum1ToitemStock(item,owner, id){
  var hpQty = itemStockFromProductList(owner, id);
  $("#"+owner+"_product_container > div[item_id='"+id+"']").attr('stock',(hpQty + 1));
}

function itemStockFromProductList(user, id){
  var result = parseInt($("#"+user+"_product_container div[item_id='"+id+"']").attr('stock'),10);
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
  var tipoElemento = getElementModifiedClass();

  $('#usuario_dinero').attr("name",""+tipoElemento+"[money][nil]").attr("value",0);
  $('#usuario_id').attr("value",0);
}


//Importantisima la funcion que me ayuda a saber si hablamos de una oferta

function isOffer(){
  if ($(".edit_negotiation")[0]){
   return false;
  }else{
    return true;
  }
}

//Fin funciones de ayuda para la ejecucion de los procesos de nueva oferta