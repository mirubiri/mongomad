function buildOfferMosaic(){
  $('#ppal_container')
  .masonry('destroy')
  .masonry({
      itemSelector : '.offer',
      isAnimated: true
  });
}

function buildThingMosaic(){
  $('#ppal_container')
  .masonry('destroy')
  .masonry({
      itemSelector : '.thing',
      isAnimated: true
  });
}