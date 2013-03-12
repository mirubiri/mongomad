function reloadPrincipalContainersHeighs(){
  $('#ppal_container').css({'height': 0  + 'px'});
  $('#user-side').css({'height': 0  + 'px'});
  $('#content-side').css({'height': 0  + 'px'});
}

function matchPrincipalContainersHeighs(){
  // El 90 debe coincidir con las alturas del footer + header
  var alturaVentana = $(document).height()-90;

  if ( ($('#devise_container').height()) < alturaVentana ) {
      $('#devise_container').css({'height': alturaVentana  + 'px'});
  }

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

function expandRightContainer(){
  mainWidth = $('.mainlayout').width();
  leftWidth = $('#leftContainer').width();
  rightWidth = mainWidth - leftWidth -31;
  $('#rightContainer').css({'width': rightWidth + 'px'});
}

function expandRequestContainer(){
  var alturaUserSide = $('#user-side').height();
  var alturaUserReputation = $('#user_reputation_container').height();
  var alturaUserData = $('#user_data_container').height();
  var alturaRequesContainer = alturaUserSide - alturaUserReputation  - alturaUserData -67;
  $('#user_request_list').css('height', alturaRequesContainer);
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

function setProfileContainersHeights(){
  alturaPpalContainer = $('#ppal_container').height();
  margenesEnPerfil = 10;
  alturaDisponible = alturaPpalContainer - margenesEnPerfil;
  alturaPerfil = (alturaDisponible * 40)/100;
  alturaComentarios = (alturaDisponible * 60)/100;

  $('.person_info').css({'height': alturaPerfil  + 'px'});
  $('.person_info,.statistics').equalHeightColumns();
  $('.comments_recieved').css({'height': alturaComentarios  + 'px'});  
}

function masonryOffer(){
  $('#ppal_container').masonry({
      itemSelector : '.offer',
      isAnimated: true
  });
}

function masonryThing(){
  $('#ppal_container').masonry({
      itemSelector : '.thing',
      isAnimated: true
  });
}

function ajaxLinksUrlChange(){ 
  $('#navigation_bar li a').live('click',function(e){
      $.getScript(this.href);
      var url= this.href;
      history.pushState({path:url},"", url);
      $('#ppal_container').removeClass('masonry');              
  });

  $('#menu_user_data .btn-toolbar .btn-group a').live('click',function(e){
      $.getScript(this.href);
      var url= this.href;
      history.pushState({path:url},"", url);
      $('#ppal_container').removeClass('masonry');
  });

  $(window).bind("popstate", function() {
    $.getScript(location.href);
  });
}

function buttonsClickBackgroundChange(){
  $('#navigation_bar li a').live('click',function(e){
    $('#menu_user_data .btn-toolbar .btn-group a').removeClass("active");             
  });
  $('#menu_user_data .btn-toolbar .btn-group a').live('click',function(e){
    $('#menu_user_data .btn-toolbar .btn-group a').removeClass("active");
    $('#navigation_bar li').removeClass("active"); 
    $(this).addClass('active');
  });
}


function closeModalWindows(){
  $('#new-offer-send-button').live('click',function(e){
    $('#new-offer-form').addClass("container_invisible");
  });
  $('#new-thing-send-button').live('click',function(e){
    $('#new-thing-form').addClass("container_invisible");
  });
  $('#edit-thing-send-button').live('click',function(e){
    $('#edit-thing-form').addClass("container_invisible");
  });
  $("form").bind("ajax:success", function(xhr, data, status){
    $.modal.close();
  });
}

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
        $("#summary_offer_"+t+"_products_container").append("<input type=\"hidden\" name=\"offer["+u+"_things[]][thing_id]\" value=\""+ selector.attr("id") + "\" />");
        $("#summary_offer_"+t+"_products_container").append("<input type=\"hidden\" name=\"offer["+u+"_things[]][quantity]\" value=\""+ 1 + "\" id=\""+ selector.attr("id") + "\" />");
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
  //FIn funciones de ayuda para la ejecucion de los procesos de nueva oferta

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

function slideOptionsPanel(){
  $(".triangle > #options_button").live('click',function(e){
    $(this).parent().parent().parent().find('#options').slideToggle('fast');
    e.preventDefault();
  });
}

function activateAlertButton(){
  $('.user_alert').hover(
     function() {
        $(this).find('#alert_button').removeClass("hidden_container");
     }, 
     function() {
        $(this).find('#alert_button').addClass("hidden_container");
     }
  );
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

function activateRequestButtons(){
  $('.request').hover(
     function () {
      $(this).find('.options_menu').removeClass("hidden_container");
     }, 
     function () {
      $(this).find('.options_menu').addClass("hidden_container");
     }
  );
}

function imageSelection(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
        $('#thing_image_container').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}



$(window).load(function(){
  //slideOptionsPanel();
  closeModalWindows();
  masonryOffer();
  ajaxLinksUrlChange();
  newOfferScript();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  expandRightContainer();  
  activateRequestButtons();
  activateOfferButton();
  activateNegotiationButtons();
  buttonsClickBackgroundChange();
  imageSelection();
});

$(window).bind('resize', function() {
  reloadPrincipalContainersHeighs();
  matchPrincipalContainersHeighs();
  expandRequestContainer();
  expandRightContainer();
  linksClickBackgroundChange();
  buttonsClickBackgroundChange();
  activateAlertButton();
  imageSelection();
});