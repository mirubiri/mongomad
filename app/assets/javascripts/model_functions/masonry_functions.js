function activateMasonry(){
  // //alert("mosaico de ofers");
  // var ppalContainer = $('#ppal_container');

  // if (ppalContainer.hasClass('masonry')) {
  //   ppalContainer.masonry('reload');
  // }else{
  //   ppalContainer.masonry({
  //     itemSelector : '.offer',
  //     isAnimated: true
  //   });
  // }
}

function destroyMasonry(){
  //$('#ppal_container').masonry('destroy');
}


(function ($)
{
  $.fn.buildOfferMasonry = function (){
    alert("masonry disparado");

    $(this).masonry({
      itemSelector : '.offer',
      isAnimated: true
    });

    return $(this);
  };

})(jQuery);



(function ($)
{
  $.fn.buildItemMasonry = function (){
    alert("masonry disparado");

    $(this).masonry({
      itemSelector : '.item',
      isAnimated: true
    });

    return $(this);
  };

})(jQuery);



(function ($)
{
  $.fn.destroyMasonry = function (){
    $(this).masonry('destroy');
    return $(this);
  };
})(jQuery);
