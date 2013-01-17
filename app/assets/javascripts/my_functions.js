function matchPrincipalContainersHeighs(){
  var alturaVentana = $(document).height()-90;// alturas del footer + header
  
  if ( ($('#user-side').height()) < alturaVentana ) {
      $('#user-side').css({'height': alturaVentana  + 'px'});
  }

  $('#user-side,#content-side').equalHeightColumns();
  $('#user-side,#ppal_container').equalHeightColumns();

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
            $('#content-side #ppal_container').masonry({
                itemSelector : '.offer',
                gutterWidth: 14,
                columnWidth : 266,
                isAnimated: true
            });
        break;

        case "products":
            $('#content-side #ppal_container').masonry({
                itemSelector : '.product',
                gutterWidth: 13,
                columnWidth : 195,
                isAnimated: true
            });
        break;

        case "home":
            $('#content-side #ppal_container').masonry({
                itemSelector : '.offer',
                gutterWidth: 14,
                columnWidth : 266,
                isAnimated: true
            });
        break;
    }
}

function ajaxLinks(){
    $('#link_offers').click(function(e){
        $.getScript(this.href);
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_negotiations').click(function(e){
        $.getScript(this.href);
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_deals').click(function(e){
        $.getScript(this.href);
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_profile').click(function(e){
        $.getScript(this.href);
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_things').click(function(e){
        $.getScript(this.href);
        var url= this.href;
        history.pushState({path:url},"", url);
    });

    $(window).bind("popstate", function() {
      $.getScript(location.href);
    });
}

function modalWindows(){
  $('#new-request-form').hide();
  $('#new-offer-form').hide();

  $('#add_request_button').click(function(e){
      e.preventDefault();
      $('#new-request-form').modal({
          opacity:60,
          overlayCss: {backgroundColor:"#000000"}
      });
  });

  $('#new-offer-button').click(function(e){
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
    $('#nueva-oferta-mis-productos .nueva-oferta-producto').click(function(){
        $(this).clone().prependTo('.nueva-oferta-mesa-cuerpo-item-izda');
        $('.nueva-oferta-mesa-cuerpo-item-izda .nueva-oferta-producto .nueva-oferta-producto-titulo input').attr('checked', 'checked');
    });


    $('#nueva-oferta-sus-productos .nueva-oferta-producto').click(function(){
        $(this).clone().prependTo('.nueva-oferta-mesa-cuerpo-item-dcha-superior');
        $('.nueva-oferta-mesa-cuerpo-item-dcha-superior .nueva-oferta-producto .nueva-oferta-producto-titulo input').attr('checked', 'checked');

    });

    $('#agregar-mis-productos').click(function(){
        $('#nueva-oferta-mis-productos').toggle();
        });

    $('#agregar-sus-productos').click(function(){
        $('#nueva-oferta-sus-productos').toggle();
    });

    $('#eliminarMiProducto').click(function(){
        alert("entrar entra");
        $(this).parent().remove();
    });

    $('#eliminarSuProducto').click(function(){
        alert("entrar entra");
        $(this).parent().remove();
    });

    $('.quitaProducto').live('click',function() {
        $(this).parent("div").remove();
    });
}

$(document).ready(function() {
  modalWindows();
  newOfferModal();
  applyMasonry();
  addProfileCommentsSeparator();
  maximizeConversationsHeights();
  matchPrincipalContainersHeighs();
});

$(window).load(function(){
  applyMasonry();
  ajaxLinks();
  addProfileCommentsSeparator();
  maximizeConversationsHeights();
  matchPrincipalContainersHeighs();
});

$(window).bind('resize', function() {
  applyMasonry();
  maximizeConversationsHeights();
  matchPrincipalContainersHeighs();
});