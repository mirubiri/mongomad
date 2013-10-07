(function ($)
{
  $.fn.setHeaderPadding = function (){

    var mainLayout = $('#mainLayout');
    var mainLayoutPadding = mainLayout.css('padding-left').replace("px","");

    $(this).css('padding-left', mainLayoutPadding);
    $(this).css('padding-right', mainLayoutPadding);

    return $(this);
  };


})(jQuery);