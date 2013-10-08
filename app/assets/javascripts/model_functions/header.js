(function ($)
{
  $.fn.setHeaderPadding = function (){

    var mainLayout = $('#mainLayout');
    var mainLayoutPadding = mainLayout.css('padding-left').replace("px","");

    $(this).css('padding-left', mainLayoutPadding + "px");
    $(this).css('padding-right', mainLayoutPadding + "px");

    return $(this);
  };


})(jQuery);