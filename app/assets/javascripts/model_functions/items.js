function imageSelection(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $('#item_image_container').attr('src', e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

function resizeItems(){
  var anchuraTotal = $("#ppal_container").width();
  var ofertasEntran = offersFit(286,anchuraTotal);
  var aumentoPorcentual = ofertasEntran * 1.25;
  var productosEntran = Math.round(aumentoPorcentual);
  var margenOcupanitems = productosEntran * 10;
  var anchuraDisponible = anchuraTotal - margenOcupanitems;
  var anchuraProducto = anchuraDisponible/productosEntran;

  $(".item").css({'width': anchuraProducto +'px'});
  $(".item > .item_image > img").css({'height': anchuraProducto +'px'});
}
