// Trigger para los elementos de navegacion del menu general de la pagina
$('#navigation_bar li a').live('click',function(e){
    $('#menu_user_data .btn-toolbar .btn-group a').removeClass("active");
    $('#ppal_container').removeClass('masonry');

    $.getScript(this.href);
    var url= this.href;
    history.pushState({path:url},"", url);
});


// Trigger para los elementos de navegacion del contenedor principal
$('.btn-group a').live('click',function(e){
    $('#ppal_container').removeClass('masonry');

    $.getScript(this.href);
    var url= this.href;
    history.pushState({path:url},"", url);
});



// Trigger para los elementos de navegacion en panel de usuario
$('#menu_user_data .btn-toolbar .btn-group a').live('click',function(e){
    $('#menu_user_data .btn-toolbar .btn-group a').removeClass("active");
    $('#navigation_bar li').removeClass("active");
    $('#ppal_container').removeClass('masonry');

    $(this).addClass('active');
    $.getScript(this.href);
    var url= this.href;
    history.pushState({path:url},"", url);
});

// Recoge los cambios de url
$(window).bind("popstate", function() {
    $.getScript(location.href);
});



