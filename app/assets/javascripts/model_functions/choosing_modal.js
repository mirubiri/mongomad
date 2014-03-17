(function ($)
{
  $.fn.firstUserSelected = function(){
    //alert("se carga el js");
    $(this).find('.user_image').first().children(":first").css('box-shadow','0px 3px 5px red, 0px -3px 5px red');
    return $(this);
  };

})(jQuery);



(function ($)
{
  $.fn.userSelection = function(user1,user2,message){

    $(this).find("#composer_content_area").removeClass('hidden_container');
    $(this).find("#message_content_area").removeClass('hidden_container');

    $(this).enableUserSelected(user1);
    $(this).disableUserSelected(user2);
    $(this).disableUserSelected(message);

    return $(this);
  };

})(jQuery);



(function ($)
{
  $.fn.enableUserSelected = function(user){

    $(this).find("#"+user+"_selector_area").children(":first").children(":first").css('box-shadow','0px 3px 5px red, 0px -3px 5px red');
    $(this).find("#"+user+"_products_container").removeClass("container_invisible");
    $(this).find("#"+user+"_content_area").show();

    return $(this);
  };

})(jQuery);



(function ($)
{
  $.fn.disableUserSelected = function(user){

    $(this).find("#"+user+"_selector_area").children(":first").children(":first").css('box-shadow','0px 3px 5px #888, 0px -3px 5px #888');
    $(this).find("#"+user+"_products_container").addClass("container_invisible");
    $(this).find("#"+user+"_content_area").hide();

    return $(this);
  };

})(jQuery);


(function ($)
{
  $.fn.addProductToSummary = function(){

    //alert("empiezo a añadir");

    var product_id = $(this).attr("id");
    var owner_id = $(this).attr("owner_id");
    var tipoElemento = $(this).attr("type");
    var productSide = $(this).attr("side");
    //var posicion = howMuchInputsAre(productSide) + 1;

    if(tipoElemento == "Cash"){
      var amount = $(this).find('textarea').val();
      var inputString ="<div class='data_input'>"+
<<<<<<< HEAD
        "<input type=\"hidden\" name=\"offer[goods][][owner_id]\" value=\""+product_id+"\" />" +
        "<input type=\"hidden\" name=\"offer[goods][][type]\" value=\""+tipoElemento+"\" />" +
        "<input type=\"hidden\" name=\"offer[goods][][amount]\" value=\""+amount+"\" />" +
=======
        "<input type=\"hidden\" name=\"offer[cash][][owner_id]\" value=\""+owner_id+"\" />" +
        //"<input type=\"hidden\" name=\"offer[cash][][type]\" value=\""+tipoElemento+"\" />" +
        "<input type=\"hidden\" name=\"offer[cash][][amount]\" value=\""+amount+"\" />" +
>>>>>>> e44d8aa9d444479feb8906951e9f35724588ae21

        "</div>";
    }else{
      var inputString ="<div class='data_input'>"+
        "<input type=\"hidden\" name=\"offer[products][][item_id]\" value=\""+product_id+"\" />" +
        //"<input type=\"hidden\" name=\"offer[products][][type]\" value=\""+tipoElemento+"\" />" +
        "</div>";
    }

    // alert(product_id);
    // alert(tipoElemento);
    // alert(productSide);
    // alert(posicion);

    if (isitemInOffer(productSide,product_id)){
     // alert("THE PRODUCT IS ALREADY CHOOSEN");
    }
    else{
      // TODO: If product is money, should clone with the quantity and be uneditable
      // var amount = $(this).find('textarea').val();
      // $(this).clone(false).appendTo('.summary'+productSide)
      // .find('textarea').attr('readonly','readonly').html(amount)
      // .append(inputString)
      // .removeAttr('style')
      // .children('.item_image')
      // .removeAttr('style');

      //alert("no estoy en el sumario");
      $(this).clone(false).appendTo('.summary'+productSide)
      .append(inputString)
      .removeAttr('style')
      .children('.item_image')
      .removeAttr('style');
    }

    //$("#offer_summary").attr('maxItems',posicion);

    return $(this);
  };

})(jQuery);


(function ($)
{
  $.fn.removeProductFromSummary = function(){
    var id = $(this).attr('id');
    $(".products_list").find("#"+id).find('.offer_artistic_layer').remove();
    $(this).remove();
  };

})(jQuery);


function isitemInOffer(side, id){
  if ( $('.summary'+side).find('#'+id).length > 0 ){
    //alert("si esta");
    return true;
  } else {
    //alert("no está");
    return false;
  }
}


// function howMuchInputsAre(side){
//   var items = $("#offer_summary").attr('maxItems');
//   items = parseInt(items, 10);
//   return items;
// }
