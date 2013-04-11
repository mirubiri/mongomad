function masonryOffer(){
  $('#ppal_container').masonry('destroy');
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