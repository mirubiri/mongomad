function ajaxLinksUrlChange(){
  $('#navigation_bar li a').live('click',function(e){
      $.getScript(this.href);
      var url= this.href;
      history.pushState({path:url},"", url);
      $('#ppal_container').removeClass('masonry');
  });

  $('#menu_user_data .btn-toolbar .btn-group a').live('click',function(e){
      $.getScript(this.href);
      var url= this.href;
      history.pushState({path:url},"", url);
      $('#ppal_container').removeClass('masonry');
  });

  $(window).bind("popstate", function() {
    $.getScript(location.href);
  });
}