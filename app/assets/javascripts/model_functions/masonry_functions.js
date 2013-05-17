function buildOfferMosaic(){

  var ppalContainer = $('#ppal_container');
  var ppalContainerFirstChild = $('#ppal_container div:first-child');

  if (ppalContainerFirstChild.hasClass('masonry-brick')) {
    ppalContainer.masonry('destroy');
  }

  ppalContainer.masonry({
      itemSelector : '.offer',
      isAnimated: true
  });

}


function buildThingMosaic(){

  var ppalContainer = $('#ppal_container');
  var ppalContainerFirstChild = $('#ppal_container div:first-child');

  if (ppalContainerFirstChild.hasClass('masonry-brick')) {
    ppalContainer.masonry('destroy');
  }

  ppalContainer.masonry({
      itemSelector : '.thing',
      isAnimated: true
  });

}

function destroyMasonry(){
  $('#ppal_container').masonry('destroy');
}