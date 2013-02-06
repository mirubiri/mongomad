function matchPrincipalContainersHeighs(){
  var alturaVentana = $(document).height()-90;// alturas del footer + header

  if ( ($('#user-side').height()) < alturaVentana ) {
      $('#user-side').css({'height': alturaVentana  + 'px'});
  }

  $('#user-side,#content-side').equalHeightColumns();
  $('#ppal_container').css({'height': ($('#user-side').height() - 70)  + 'px'});

  if ( ($('#user-side').height()) === null ) {
    $('#footer').css({'top': (alturaVentana +60)  + 'px'});
  }else{
    $('#footer').css({'top': (($('#user-side').height()) + 55) + 'px'});
  }
}

function maximizeConversationsHeights(){
  $("[id^=negotiation]").each(function(){
    $(this).equalHeightColumns({children:':not(h2,p)'});
  });
  $("[id^=conversationofnegotiation]").each(function(){
    $(this).css({'height':($(this).parent().height()-57)+'px'});
  });
}

function addProfileCommentsSeparator(){
  if ( ($('#comment_list').height()) > ($('#data_list').height()) ) {
      $('#comment_list').css({'border-left': '1px solid rgb(220,220,220)'});
  }else{$('#data_list').css({'border-right': '1px solid rgb(220,220,220)'});}
}

function applyMasonry(){
    var pagina = location.pathname.split("/");
    var urlTokens = 3;
    var lugar = "home";

    if (pagina.length == urlTokens + 1){
        lugar = location.pathname.split("/")[urlTokens];
    }

    switch (lugar) {
        case "offers":
            $('#ppal_container').masonry({
                itemSelector : '.offer',
                gutterWidth: 14,
                columnWidth : 266,
                isAnimated: true
            });
        break;

        case "things":
            $('#ppal_container').masonry({
                itemSelector : '.thing',
                gutterWidth: 13,
                columnWidth : 195,
                isAnimated: true
            });
        break;

        case "home":
            $('#ppal_container').masonry({
                itemSelector : '.offer',
                gutterWidth: 14,
                columnWidth : 266,
                isAnimated: true
            });
        break;
    }
}

function ajaxLinks(){
    $('#navigation_bar nav a').hover(
      function () {$(this).addClass("nav_hover");},
      function () {$(this).removeClass("nav_hover");}
    );

    $('#navigation_bar nav a').live('click',function(e){
        $.getScript(this.href);
        var url= this.href;
        history.pushState({path:url},"", url);
        $('#ppal_container').removeClass('masonry');
        $('#navigation_bar nav a').removeClass("nav_selected");
        $(this).addClass("nav_selected");
    });

    $('#menu_user_data .menu_icon a').live('click',function(e){
        $.getScript(this.href);
        var url= this.href;
        history.pushState({path:url},"", url);
        $('#ppal_container').removeClass('masonry');
    });

    $(window).bind("popstate", function() {
      $.getScript(location.href);
    });
}

function modalWindows(){

  $('#new-offer-send-button').live('click',function(e){
    $('#new-offer-form').addClass("container_invisible");
  });

  $('#new-thing-send-button').live('click',function(e){
    $('#new-thing-form').addClass("container_invisible");
  });

  $('#add_request_button').live('click',function(e){
      e.preventDefault();
      $('#new-request-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

  $('#new-thing-button').live('click',function(e){
      e.preventDefault();
      $('#new-thing-form').removeClass("container_invisible");
      $('#new-thing-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"},
          onClose: function () {
            $.modal.close();
            $('#new-thing-form').addClass("container_invisible");
          }
      });
  });

  $('#new-offer-button').live('click',function(e){
      e.preventDefault();
      $('#new-offer-form').removeClass("container_invisible");
      $('#new-offer-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"},
          onClose: function () {
            $.modal.close();
            $('#new-offer-form').addClass("container_invisible");
          }
      });
  });

  $("form").bind("ajax:success", function(xhr, data, status){
    $.modal.close();
  });
}

function newOfferModal(){

    $('#eliminarMiProducto').live('click',function(){
      $(this).parent().remove();
    });

    $('#eliminarSuProducto').live('click',function(){
      $(this).parent().remove();
    });

    $('.quitaProducto').live('click',function() {
        $(this).parent("div").remove();
    });
}

function newOfferLinks(){
  $('#new_offer_receiver_selector').live('click',function(e){
    e.preventDefault();
    $('#receiver_selector_area').addClass("user_selected");
    $('#composer_selector_area').removeClass("user_selected");
    $('#receiver_products_container').removeClass("container_invisible");
    $('#composer_products_container').addClass("container_invisible");
  });

  $('#new_offer_composer_selector').live('click',function(e){
    e.preventDefault();
    $('#composer_selector_area').addClass("user_selected");
    $('#receiver_selector_area').removeClass("user_selected");
    $('#composer_products_container').removeClass("container_invisible");
    $('#receiver_products_container').addClass("container_invisible");
  });

  $('#his_product_container .product').live('click',function(e){
    if ($("input[id='"+$(this).attr("id")+"']").length > 0){
      valr = parseInt(($("input[id='"+$(this).attr("id")+"']")).attr('value'), 10);
      $("#summary_offer_received_products_container div[id='"+$(this).attr("id")+"'] .quantity_container").html(valr+1);
      $("input[id='"+$(this).attr("id")+"']").attr('value', (valr +1 ));
      rpcv = parseInt(($('#received_products_counter').attr("value")), 10);
      $('#received_products_counter').attr('value', (rpcv + 1));
    }
    else{
      $(this).clone().appendTo('#summary_offer_given_products_container');
      $('#summary_offer_received_products_container').append("<input type=\"hidden\" name=\"receiver_things[][thing_id]\" value=\""+ $(this).attr("id") + "\" />");
      $('#summary_offer_received_products_container').append("<input type=\"hidden\" name=\"receiver_things[][quantity]\" value=\""+ 1 + "\" id=\""+ $(this).attr("id") + "\" />");
    }
  });

  $('#my_product_container .product').live('click',function(e){
    if ($("input[id='"+$(this).attr("id")+"']").length > 0){
      valr = parseInt(($("input[id='"+$(this).attr("id")+"']")).attr('value'), 10);
      $("#summary_offer_given_products_container div[id='"+$(this).attr("id")+"'] .quantity_container").html(valr+1);
      $("input[id='"+$(this).attr("id")+"']").attr('value', (valr +1 ));
      gpcv = parseInt(($('#given_products_counter').attr("value")), 10);
      $('#given_products_counter').attr('value', (gpcv + 1));
    }
    else{
      $(this).clone().appendTo('#summary_offer_received_products_container');
      $('#summary_offer_given_products_container').append("<input type=\"hidden\" name=\"composer_things[][thing_id]\" value=\""+ $(this).attr("id") + "\" />");
      $('#summary_offer_given_products_container').append("<input type=\"hidden\" name=\"composer_things[][quantity]\" value=\""+ 1 + "\" id=\""+ $(this).attr("id") + "\" />");
    }
  });

  $('#dineroPidesBotonAgregar').live('click',function(e){
    e.preventDefault();
    $('#dineroPidesEnSumario').empty();
    $('#dineroPidesEnSumario').append($.trim($("#dineroPides").val()));
    $('#dineroPidesEnSumario').append('<a href="#blank">x</a>');
    $('#dineroOfrecesBotonAgregar').addClass("container_invisible");
    $('#usuario_id').attr( "value",$('#new_offer_receiver_selector').attr("value"));
    $('#usuario_dinero').attr("value",$("#dineroPides").val());
    $('#dineroPides').val("");
  });

  $('#dineroOfrecesBotonAgregar').live('click',function(e){
    e.preventDefault();
    $('#dineroOfrecesEnSumario').empty();
    $('#dineroOfrecesEnSumario').append($.trim($("#dineroOfreces").val()));
    $('#dineroOfrecesEnSumario').append('<a href="#blank">x</a>');
    $('#dineroPidesBotonAgregar').addClass("container_invisible");
    $('#usuario_id').attr( "value",$('#new_offer_composer_selector').attr("value"));
    $('#usuario_dinero').attr("value",$("#dineroOfreces").val());
    $('#dineroOfreces').val("");
  });

  $('#dineroPidesEnSumario a').live('click',function(e){
    e.preventDefault();
    $(this).parent().empty();
    $('#dineroOfrecesBotonAgregar').removeClass("container_invisible");
    $('#usuario_dinero').attr("name", "offer[money][nil]");
    $('#usuario_dinero').attr("value",0);
    $('#usuario_id').attr("value",0);
  });

  $('#dineroOfrecesEnSumario a').live('click',function(e){
    e.preventDefault();
    $(this).parent().empty();
    $('#dineroPidesBotonAgregar').removeClass("container_invisible");
    $('#usuario_dinero').attr("name", "offer[money][nil]");
    $('#usuario_dinero').attr("value",0);
    $('#usuario_id').attr("value",0);
  });



}

$(window).load(function(){
  modalWindows();
  newOfferModal();
  applyMasonry();
  ajaxLinks();
  newOfferLinks();
  addProfileCommentsSeparator();
  maximizeConversationsHeights();
  matchPrincipalContainersHeighs();
});

$(window).bind('resize', function() {
  maximizeConversationsHeights();
  matchPrincipalContainersHeighs();
});