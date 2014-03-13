function imageSelection(input, selector) {

  var input_selector = selector.toString();
  //alert(input_selector);

  if (input.files && input.files[0]) {

    var reader = new FileReader();

    reader.onload = function (e) {

        var image = new Image();
        image.src = e.target.result;

        if (input_selector == "1"){
            image.onload = function(event) {
              $("#inputcontainer1").find('img').attr('src', this.src);
              var image = $("#inputcontainer1").find('img').clone();
              $('#original_image_container').find('img').replaceWith(image);
            };
        }else if(input_selector == "2"){
            image.onload = function(event) {
              $("#inputcontainer2").find('img').attr('src', this.src);
              var image = $("#inputcontainer2").find('img').clone();
              $('#original_image_container').find('img').replaceWith(image);
            };
        }else{
            image.onload = function(event) {
              $("#inputcontainer3").find('img').attr('src', this.src);
              var image = $("#inputcontainer3").find('img').clone();
              $('#original_image_container').find('img').replaceWith(image);
            };
        }

    };

    reader.readAsDataURL(input.files[0]);

  }
}


(function ($)
{
  $.fn.setItemWidth = function (){

    //alert("entra en funcionamiento el setItemWidth");

    //Compruebo la anchura que tengo
    var parent = $(this).parent();

    if (parent.hasClass('main_container_elementList')) {
        var espacioUtil = parent.width();
    }else{
        var espacioUtil = parent.width();//EN la modal siempre aparece la scrollbar al cargar ambos contenedores, y debo contar con su anchura
    }

    //alert(espacioUtil);

    //Pongo los tamaños de los items todos a 0
    $(this).width(0);
    $(this).find('.item_image').width(0);
    $(this).find('.item_image').height(0);

    //Variables que miden el intervalo de tamaño para los productos
    var minWidth = 150;
    var maxWidth = 200;

    //Numero de elementos que entran en los extremos del intervalo
    var elementsInMinWidth = Math.floor(espacioUtil / minWidth);
    var elementsInMaxWidth = Math.floor(espacioUtil / maxWidth);
    //alert(elementsInMinWidth);


    //Anchura resultante para el extremo inferior del margen
    var anchuraItem = (espacioUtil/elementsInMinWidth) -20; // el 20 son 10 de margen de cada item + 5 de padding a cada lado
    //alert(anchuraItem);
    $(this).width(anchuraItem);
    $(this).find('.item_image').width(anchuraItem);
    $(this).find('.item_image').height(anchuraItem);


    return $(this);
  };

})(jQuery);
