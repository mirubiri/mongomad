function ejecutarMasonry(){
    var pagina = location.pathname.split("/");
    var urlTokens = 3;
    var lugar = "home";

    if (pagina.length != urlTokens){
        lugar = location.pathname.split("/")[urlTokens];
    }

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
            $('#content-side #ppal_container').masonry({
                itemSelector : '.product',
                gutterWidth: 13,
                columnWidth : 195,
                isAnimated: true
            });
        break;

        case "home":
            $('#content-side #ppal_container').masonry({
                itemSelector : '.offer',
                gutterWidth: 14,
                columnWidth : 266,
                isAnimated: true
            });
        break;
    }
}