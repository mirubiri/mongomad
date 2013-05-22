function buildOfferMosaic(){
  var ppalContainer = $('#ppal_container');

  if (ppalContainer.hasClass('masonry')) {
    ppalContainer.masonry('reloadItems');
  }else{
    ppalContainer.masonry({
      itemSelector : '.offer',
      isAnimated: true
    });
  }  
}

function destroyMasonry(){
  $('#ppal_container').masonry('destroy');
}