$(window).load(function() {
    $('#link_offers').click(function(e){
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_negotiations').click(function(e){
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_deals').click(function(e){
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_profile').click(function(e){
        var url= this.href;
        history.pushState({path:url},"", url);
    });
    $('#link_things').click(function(e){
        var url= this.href;
        history.pushState({path:url},"", url);
    });
});
