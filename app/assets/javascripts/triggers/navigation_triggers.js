//Control de la navegacion de la barra del header
$(function(){
    $('#page_header_options').on('click','a',function(e){
        event.preventDefault();
        var url= this.href;
        history.pushState({path:url},"", url);
    });
});


//Control de la navegacion de la barra del ppal_container
$(function(){
    $("#navigation_bar").on('click','a', function(event){
        event.preventDefault();
        var url= this.href;
        history.pushState({path:url},"", url);
    });
});


//Control de la redireccion url cuando negociamos una oferta
$(function(){
    $(document).on('click','#negotiate_button', function(event){
        var url = $(this).attr('url');
        history.pushState({path:url},"", url);
    });
});


// Recoge los cambios de url
$(window).on("popstate", function() {
    $.getScript(location.href);
});


