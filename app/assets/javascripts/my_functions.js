function matchPrincipalContainersHeighs(){
  var alturaVentana = $(document).height()-90;// alturas del footer + header

  if ( ($('#user-side').height()) < alturaVentana ) {
      $('#user-side').css({'height': alturaVentana  + 'px'});
  }

  $('#user-side,#content-side').equalHeightColumns();
  $('#ppal_container').css({'height': ($('#user-side').height() - 90)  + 'px'});

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
  $('#new-request-form').hide();
  $('#new-offer-form').hide();

  $('#add_request_button').live('click',function(e){
      e.preventDefault();
      $('#new-request-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

  $('#new-offer-button').live('click',function(e){
      e.preventDefault();

      $('#new-offer-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

  $("form").bind("ajax:success", function(xhr, data, status){
    $.modal.close();
  });
}

function newOfferModal(){
    $('#nueva-oferta-mis-productos .nueva-oferta-producto').live('click',function(){
        $(this).clone().prependTo('.nueva-oferta-mesa-cuerpo-item-izda');
        $('.nueva-oferta-mesa-cuerpo-item-izda .nueva-oferta-producto .nueva-oferta-producto-titulo input').attr('checked', 'checked');
    });


    $('#nueva-oferta-sus-productos .nueva-oferta-producto').live('click',function(){
        $(this).clone().prependTo('.nueva-oferta-mesa-cuerpo-item-dcha-superior');
        $('.nueva-oferta-mesa-cuerpo-item-dcha-superior .nueva-oferta-producto .nueva-oferta-producto-titulo input').attr('checked', 'checked');

    });

    $('#agregar-mis-productos').live('click',function(){
        $('#nueva-oferta-mis-productos').toggle();
        });

    $('#agregar-sus-productos').live('click',function(){
        $('#nueva-oferta-sus-productos').toggle();
    });

    $('#eliminarMiProducto').live('click',function(){
        alert("entrar entra");
        $(this).parent().remove();
    });

    $('#eliminarSuProducto').live('click',function(){
        alert("entrar entra");
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

    $('#receiver_products_container .product_container .product').live('click',function(e){
      $(this).clone().appendTo('#summary_offer_given_products_container');
    });

    $('#composer_products_container .product_container .product').live('click',function(e){
      $(this).clone().appendTo('#summary_offer_received_products_container');
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