$(document).ready(function() {

    //alert("vigilante dice: nuevaOferta.js funciona");

    $('#nueva-oferta-mis-productos .nueva-oferta-producto').click(function(){
        $(this).clone().prependTo('.nueva-oferta-mesa-cuerpo-item-izda');
        $('.nueva-oferta-mesa-cuerpo-item-izda .nueva-oferta-producto .nueva-oferta-producto-titulo input').attr('checked', 'checked');
    });


    $('#nueva-oferta-sus-productos .nueva-oferta-producto').click(function(){
        $(this).clone().prependTo('.nueva-oferta-mesa-cuerpo-item-dcha-superior');
        $('.nueva-oferta-mesa-cuerpo-item-dcha-superior .nueva-oferta-producto .nueva-oferta-producto-titulo input').attr('checked', 'checked');

    });

    $('#agregar-mis-productos').click(function(){
        $('#nueva-oferta-mis-productos').toggle();
        });

    $('#agregar-sus-productos').click(function(){
        $('#nueva-oferta-sus-productos').toggle();
    });

    $('#eliminarMiProducto').click(function(){
        alert("entrar entra");
        $(this).parent().remove();
    });

    $('#eliminarSuProducto').click(function(){
        alert("entrar entra");
        $(this).parent().remove();
    });

    $('.quitaProducto').live('click',function() {
        $(this).parent("div").remove();
    });

});