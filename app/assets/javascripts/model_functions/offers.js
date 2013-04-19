function newOfferScript(){
  //Funciones de ayuda para la ejecucion de los procesos de nueva oferta

  function userSelection(a,b){
    $("#"+a+"_selector_area").addClass("user_selected");
    $("#"+b+"_selector_area").removeClass("user_selected");
    $("#"+a+"_products_container").removeClass("container_invisible");
    $("#"+b+"_products_container").addClass("container_invisible");
  }

  function thingAddition(t, u, thing){

    thing_in_offer(thing) ? sum_1_to_thing(thing,t) : add_thing_to_summary(thing,t,u);

  }

  function thing_in_offer(thing){ if ($("input[id='"+thing.attr("id")+"']").length > 0) {return true} else{return false} }

  function sum_1_to_thing(thing,t){
    var valr = parseInt(($("input[id='"+thing.attr("id")+"']")).attr('value'), 10);
    $("#summary_offer_"+t+"_products_container div[id='"+thing.attr("id")+"'] .quantity_container").html(valr+1);
    $("input[id='"+thing.attr("id")+"']").attr('value', (valr +1 ));
  }

  function add_thing_to_summary(thing,t,u){
    var id = thing.attr("id");
    $("#summary_offer_"+t+"_products_container input[rel='"+id+"']").remove();
    thing.clone().prepend('<div class="delete_button">x</div>').appendTo("#summary_offer_"+t+"_products_container").children('.quantity_container').html("1");
    $("#summary_offer_"+t+"_products_container").append("<input type=\"hidden\" name=\"offer["+u+"_attributes][products_attributes][][thing_id]\" value=\""+ id + "\" />");
    $("#summary_offer_"+t+"_products_container").append("<input type=\"hidden\" name=\"offer["+u+"_attributes][products_attributes][][quantity]\" value=\""+ 1 + "\" id=\""+ id + "\" />");
  }

  function deduct_1_to_thing(thing){
    var prdStock = parseInt(thing.attr('value'), 10);
    thing.children('.quantity_container').html(prdStock - 1);
    thing.attr('value',(prdStock-1));
  }

  function have_stock(thing){
    var prdStock = parseInt(thing.attr('value'), 10);
    if (prdStock > 0) { return true; } else { return false; }
  }


  function thingSubtraction(t,u,thing){

    if (have_more_than_one(thing)){
      deduct_1_to_product(thing,t);
    }
    else{
      delete_from_summary(thing,t,u);
    }
    add_1_to_thing(thing,u);
  }


  function have_more_than_one(thing){
    var prdQty = parseInt(($("input[id='"+thing.parent().attr("id")+"']")).attr('value'), 10);
    if (prdQty > 1){
      return true;
    }
    else{
      return false;
    }
  }

  function deduct_1_to_product(thing,t){
    var prdQty = parseInt(($("input[id='"+thing.parent().attr("id")+"']")).attr('value'), 10);
    $("#summary_offer_"+t+"_products_container div[id='"+thing.parent().attr("id")+"'] .quantity_container").html(prdQty-1);
    $("input[id='"+thing.parent().attr("id")+"']").attr('value',(prdQty-1));
  }

  function delete_from_summary(thing,t,u){
    var id = thing.parent().attr("id");
    $("#summary_offer_"+t+"_products_container").append("<input type=\"hidden\" name=\"offer["+u+"_attributes][products_attributes][_destroy]\" value=\""+1+"\" rel=\""+id+"\"/>");
    thing.parent().remove();
    $("#summary_offer_"+t+"_products_container input[id='"+id+"']").remove();
    $("#summary_offer_"+t+"_products_container input[value='"+id+"']").remove();
  }

  function add_1_to_thing(thing,u){
    var hpQty = parseInt($("#"+u+"_product_container div[id='"+thing.parent().attr("id")+"']").attr('value'),10);
    $("#"+u+"_product_container div[id='"+thing.parent().attr("id")+"']").attr('value',(hpQty + 1));
    $("#"+u+"_product_container div[id='"+thing.parent().attr("id")+"']").children('.quantity_container').html(hpQty +1);
  }

  function addMoneySumary(a1,a2,u){
    $("#dinero"+a1+"EnSumario").empty().append($.trim($("#dinero"+a1+"").val())).append('<a href="#blank">x</a>');
    $("#dinero"+a2+"BotonAgregar").addClass("container_invisible");
    $('#usuario_id').attr( "value",$("#new_offer_"+u+"_selector").attr("value"));
    $('#usuario_dinero').attr("value",$("#dinero"+a1+"").val());
    $("#dinero"+a1+"").val("");
  }

  function deleteMoneySumary(a,selector){
    selector.parent().empty();
    $("#dinero"+a+"BotonAgregar").removeClass("container_invisible");
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
    thingSubtraction("received","his",$(this));
  });

  $('#summary_offer_given_products_container > .product > .delete_button').live('click',function(e){
    thingSubtraction("given","my",$(this));
  });

  $('#dineroPidesBotonAgregar').live('click',function(e){
    e.preventDefault();
    addMoneySumary("Pides","Ofreces","receiver");
  });

  $('#dineroOfrecesBotonAgregar').live('click',function(e){
    e.preventDefault();
    addMoneySumary("Ofreces","Pides","receiver");
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