function buttonsClickBackgroundChange(){
  $('#navigation_bar li a').live('click',function(e){
    $('#menu_user_data .btn-toolbar .btn-group a').removeClass("active");
  });
  $('#menu_user_data .btn-toolbar .btn-group a').live('click',function(e){
    $('#menu_user_data .btn-toolbar .btn-group a').removeClass("active");
    $('#navigation_bar li').removeClass("active");
    $(this).addClass('active');
  });
}