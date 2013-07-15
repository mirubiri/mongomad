function buildOfferMosaic(){
  //alert("mosaico de ofers");
  var ppalContainer = $('#ppal_container');

  if (ppalContainer.hasClass('masonry')) {
    ppalContainer.masonry('reload');
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