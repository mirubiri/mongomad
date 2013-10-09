
(function ($)
{
  $.fn.setMargins = function (){
    var ppalContainer = $(this).find('#ppal_container');
    var espacioUtil = ppalContainer.width();
    var offerWidth = ppalContainer.attr('offerWidth');
    //alert(offerWidth);
    var offersInRow = Math.floor(espacioUtil / offerWidth);
    //alert(offersInRow);

    var offersRowWidth = (offersInRow * offerWidth);
    //alert(offersRowWidht);
    var totalMargin = espacioUtil - offersRowWidth;
    var lateralMargin = totalMargin / 2;
    //alert(lateralMargin);

    $(this).css('padding-left', lateralMargin);
    $(this).css('padding-right', lateralMargin);

    return $(this);
  };


})(jQuery);








(function ($)
{
  $.fn.maximizeResizableChildren = function (){

    var fixedElementWidth = $(this).children('#leftContainer').outerWidth();
    var padding = $(this).css('padding-left').replace("px","");
    //alert(padding * 2);

    var maxWidth = $(this).innerWidth() - (padding * 2);
    //alert(maxWidth);
    var elementToDistribute = $(this).children('#rightContainer');
    var elementToDistributeWidth = maxWidth - fixedElementWidth;

    elementToDistribute.width(elementToDistributeWidth);
    //alert(elementToDistributeWidth);

    return $(this);
  };

})(jQuery);







(function ($)
{
  $.fn.expandToBodyWidth = function (){

    var bodyWidth = $(document.body).width();
    //alert("anchura del body:" + bodyWidth);
    $(this).css('width','800px');
    //alert("anchura del main reducida:" + $(this).css('width'));
    $(this).css('width', bodyWidth + "px");
    //alert("anchura del main ajustada:" + $(this).css('width'));

    return $(this);
  };

})(jQuery);







(function ($)
{
  $.fn.refresh = function() {
    var elems = $(this.selector);
    this.splice(0, this.length);
    this.push.apply( this, elems );
    return this;
  };

})(jQuery);






(function ($)
{
  $.fn.resetContainerHeight = function() {

    var totalHeight = 0;

    $(this).children().each(function(){
        totalHeight += $(this).outerHeight(true);
    });

    $(this).css({'height': totalHeight  + 'px'});

  };

})(jQuery);







(function ($)
{
  $.fn.matchPrincipalContainersHeighs = function() {

    //alert("matchPrincipalContainersHeighs funcionando");
    var alturaVentana = window.innerHeight - 80;
    //alert(alturaVentana);

    // este if amplia hasta abajo la pantalla de login
    if ( ($('#devise_container').height()) < alturaVentana ) {
      $('#devise_container').css({'height': alturaVentana  + 'px'});
    }

    if(($('#ppal_container').height() + 42) > ($('#content-side').height())) {
      //alert("esta pasando");
      $('#content-side').css({'height': ($('#ppal_container').height() + 42)  + 'px'});
    }

    var alturaRequestContainerActualizada = $('#user_data_container').outerHeight(true) + $('#user_request_list').outerHeight(true) + 32;

    if(alturaRequestContainerActualizada > ($('#user-side').height())) {
      $('#user-side').css({'height': alturaRequestContainerActualizada  + 'px'});
    }

    if ( (($('#user-side').height()) < alturaVentana) && (($('#content-side').height()) < alturaVentana) ) {
      $('#user-side').css({'height': alturaVentana  + 'px'});
      $('#content-side').css({'height': alturaVentana  + 'px'});
    }else{
      $('#user-side,#content-side').equalHeightColumns();
    }

    if ( ($('#user-side').height()) === null ) {
      $('#footer').css({'top': (alturaVentana +60)  + 'px'});
    }else{
      $('#footer').css({'top': (($('#user-side').height()) + 55) + 'px'});
    }

  };

})(jQuery);