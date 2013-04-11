function newOfferScript(){
  //Funciones de ayuda para la ejecucion de los procesos de nueva oferta

  function userSelection(a,b){
    $("#"+a+"_selector_area").addClass("user_selected");
    $("#"+b+"_selector_area").removeClass("user_selected");
    $("#"+a+"_products_container").removeClass("container_invisible");
    $("#"+b+"_products_container").addClass("container_invisible");
  }

  function thingAddition(t,u,selector){
    prdStock = parseInt(selector.attr('value'), 10);
    if(prdStock > 0){
      if ($("input[id='"+selector.attr("id")+"']").length > 0){
        valr = parseInt(($("input[id='"+selector.attr("id")+"']")).attr('value'), 10);
        $("#summary_offer_"+t+"_products_container div[id='"+selector.attr("id")+"'] .quantity_container").html(valr+1);
        $("input[id='"+selector.attr("id")+"']").attr('value', (valr +1 ));
      }
      else{
        selector.clone().prepend('<div class="delete_button">x</div>').appendTo("#summary_offer_"+t+"_products_container").children('.quantity_container').html("1");
        $("#summary_offer_"+t+"_products_container").append("<input type=\"hidden\" name=\"offer["+u+"_attributes][products_attributes][][thing_id]\" value=\""+ selector.attr("id") + "\" />");
        $("#summary_offer_"+t+"_products_container").append("<input type=\"hidden\" name=\"offer["+u+"_attributes][products_attributes][][quantity]\" value=\""+ 1 + "\" id=\""+ selector.attr("id") + "\" />");
      }
      selector.children('.quantity_container').html(prdStock - 1);
      selector.attr('value',(prdStock-1));
    }
    else{
      alert("No hay stock para este producto");
    }
  }

  function thingSubtraction(t,u,selector){
    prdQty = parseInt(($("input[id='"+selector.parent().attr("id")+"']")).attr('value'), 10);
    if (prdQty > 1){
      $("#summary_offer_"+t+"_products_container div[id='"+selector.parent().attr("id")+"'] .quantity_container").html(prdQty-1);
      $("input[id='"+selector.parent().attr("id")+"']").attr('value',(prdQty-1));
    }
    else{
      selector.parent().remove();
      $("#summary_offer_"+t+"_products_container input[id='"+selector.parent().attr("id")+"']").remove();
      $("#summary_offer_"+t+"_products_container input[value='"+selector.parent().attr("id")+"']").remove();
    }
    hpQty = parseInt($("#"+u+"_product_container div[id='"+selector.parent().attr("id")+"']").attr('value'),10);
    $("#"+u+"_product_container div[id='"+selector.parent().attr("id")+"']").attr('value',(hpQty + 1));
    $("#"+u+"_product_container div[id='"+selector.parent().attr("id")+"']").children('.quantity_container').html(hpQty +1);
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
    thingAddition("received","receiver",$(this));
  });

  $('#my_product_container .product').live('click',function(e){
    thingAddition("given","composer",$(this));
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

  offersEntran = contador;

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