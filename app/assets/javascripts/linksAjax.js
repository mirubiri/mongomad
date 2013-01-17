$(window).load(function() {

    // En la primera carga pongo bien todas las alturas y lanzo el masonry para colocar bien las ofertas y los formularios
    nuevaPropuestaScript();
    modificarOfertaScript();
    igualaAlturaContenedorPrincipal();
    ejecutarMasonry();

    //Esto hace desaparecer las notificaciones
    $('#notificaciones').hide(500);


    //*********************************************LINKS*******************************************//
    //************************************NUEVOS CONTENIDOS************************************//

    $('#propuestas').live('click',(function(e){
        e.preventDefault();
        var url = this.href;

        $('#contenedor #principal').load(url + ' .lista-ofertas',
                function (responseText, textStatus, XMLHttpRequest) {
                    if (textStatus == "success") {
                        cargarValoracionesAjax();
                        ejecutarMasonry();
                        igualaAlturaContenedorPrincipal();
                    }
        });
        history.pushState({path:url},"", url);
    }));

    $('#productos').click(function(e){
        e.preventDefault();
        var url= this.href;

        $('#contenedor #principal').load(url + ' .lista-productos',
                function (responseText, textStatus, XMLHttpRequest) {
                    if (textStatus == "success") {
                        ejecutarMasonry();
                        igualaAlturaContenedorPrincipal();
                    }
        });

        history.pushState({path:url},"", url);

    });

    $('#negociando').click(function(e){
        e.preventDefault();
        var url= this.href;

        $('#contenedor #principal').load(url + ' .lista-negociaciones',
                function (responseText, textStatus, XMLHttpRequest) {
                    if (textStatus == "success") {
                        igualaAlturaContenedorPrincipal();
                        moveScrollToBottom();
                    }
        });
        history.pushState({path:url},"", url);
    });

    $('#informacion-personal').click(function(e){
        e.preventDefault();
        var url= this.href;

        $('#contenedor #principal').load(url + ' .info-personal',
            function (responseText, textStatus, XMLHttpRequest) {
                if (textStatus == "success") {
                    igualaAlturaContenedorPrincipal();
                }
            });

        history.pushState({path:url},"", url);
    });


    //*********************************************LINKS*******************************************//
    //*************************************VENTANAS MODALES************************************//


    $('#nueva-propuesta').click(function(e){
        e.preventDefault();
        var url= this.href;

        $('#contenedor').load(url + ' #formulario-nueva-propuesta',
                function (responseText, textStatus, XMLHttpRequest) {
                    if (textStatus == "success") {
                        nuevaPropuestaScript();
                    }
                }).modal({opacity:60,overlayCss: {backgroundColor:"#000000"}
        });

        //Modifico el tamaño del contenedor para que se abra correctamente la ventana modal
        $('#contenedor').css('width','100%')
                .css('max-width','100%')
                .css('height','900px')
                .css('max-height','900px')
                .css('padding','0px');
    });

    $('#nueva-peticion').click(function(e){
        e.preventDefault();
        var url= this.href;

        $('#contenedor').load(url + ' #principal',
                function (responseText, textStatus, XMLHttpRequest) {
                    if (textStatus == "success") {
                        nuevaPropuestaScript();
                    }
                }).modal({opacity:60,overlayCss: {backgroundColor:"#000000"}
        });

        //Modifico el tamaño del contenedor para que se abra correctamente la ventana modal
        $('#contenedor').css('width','100%')
                .css('max-width','100%')
                .css('height','900px')
                .css('max-height','900px')
                .css('padding','0px');
    });

    $('#modificar-oferta').click(function(e){
        e.preventDefault();
        var url= this.href;

        $('#contenedor').load(url + ' #formulario-modifica-oferta',
                function (responseText, textStatus, XMLHttpRequest) {
                    if (textStatus == "success") {
                        igualaAlturaContenedorPrincipal();
                    }
        });

        history.pushState({path:url},"", url);
    });

    $('#editar-perfil').click(function(e){
        e.preventDefault();
        var url= this.href;

        $('#contenedor #principal').load(url + ' #formulario-editar-perfil',
                function (responseText, textStatus, XMLHttpRequest) {
                    if (textStatus == "success") {
                        igualaAlturaContenedorPrincipal();
                    }
        });

        history.pushState({path:url},"", url);
    });

});
