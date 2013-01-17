$(window).load(function() {
    $('a').click(function(e){
        e.preventDefault();
        var url= this.href;
        history.pushState({path:url},"", url);
    });
});
