function ejecutarMasonry(){
    var pagina = location.pathname.split("/");
    var ultimoPath = pagina.length-1;
    var lugar = location.pathname.split("/")[ultimoPath];

    switch (lugar) {
        case "offers":
            $('#content-side #ppal_container').masonry({
                itemSelector : '.offer',
                gutterWidth: 14,
                columnWidth : 266,
                isAnimated: true
            });
        break;

        case "products":
            $('#content-side #ppal_container_products').masonry({
                itemSelector : '.product',
                gutterWidth: 13,
                columnWidth : 195,
                isAnimated: true
            });
        break;
    }
}