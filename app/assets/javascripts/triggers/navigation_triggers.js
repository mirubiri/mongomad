//Control de la navegacion de la barra del header
$(function(){
    $('#page_header_options').on('click','a',function(e){
        event.preventDefault();

        $.getScript(this.href);

        var url= this.href;
        history.pushState({path:url},"", url);
    });
});


//Control de la navegacion de la barra del ppal_container
$(function(){
    $("#navigation_bar").on('click','a', function(event){
        event.preventDefault();

        $("#navigation_bar_menu").children('li').removeClass('active');
        $(this).parent().addClass('active');

        $.getScript(this.href); // Todos los index.js

        var url= this.href;
        history.pushState({path:url},"", url);
    });
});


//Control de la redireccion url cuando negociamos una oferta
$(function(){
    $("#offer_buttons_navigation form").on("click",'input', function(event){
        alert("esto funciona");
        event.preventDefault();

        var url= this.url;
        history.pushState({path:url},"", url);
    });
});


// Recoge los cambios de url
$(window).on("popstate", function() {
    $.getScript(location.href);
});


