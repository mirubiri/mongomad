function imageSelection(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $('#thing_image_container').attr('src', e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

function resizeThings(){
  var anchuraTotal = $("#ppal_container").width();
  var ofertasEntran = offersFit(286,anchuraTotal);
  var aumentoPorcentual = ofertasEntran * 1.25;
  var productosEntran = Math.round(aumentoPorcentual);
  var margenOcupanThings = productosEntran * 10;
  var anchuraDisponible = anchuraTotal - margenOcupanThings;
  var anchuraProducto = anchuraDisponible/productosEntran;

  $(".thing").css({'width': anchuraProducto +'px'});
  $(".thing > .thing_image > img").css({'height': anchuraProducto +'px'});
}
