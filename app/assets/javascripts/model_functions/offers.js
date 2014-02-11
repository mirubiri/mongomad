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


(function ($)
{
  $.fn.previewItem = function(){

    $(this).on('mouseover mouseout','.item', function(event) {
      if (event.type == 'mouseover') {
        $(".products_container").find('#overview_image').html($(this).find('.item_image').html()).find('img').width(128).height(128);
        $(".products_container").find('#overview_description_title').html($(this).attr('name'));
        $(".products_container").find('#overview_description_text').html($(this).attr('description'));
        //$(".product_overview").show();
      } else {
        //$(".product_overview").hide();
        $(".products_container").find('#overview_image').html("<p>Imagen</p>");
        $(".products_container").find('#overview_description_title').html("<p>Titulo del Producto</p>");
        $(".products_container").find('#overview_description_text').html("<p>Descripcion del Producto</p>");
      }
    });

    return $(this);
  };

})(jQuery);


