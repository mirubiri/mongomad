(function ($)
{
  $.fn.toModal = function(){
    id = $(this).attr("id");
    $("#" + id).modal({
      modal: true,
      close: true,
      closeHTML: "close",
      minWidth: 800,
      minHeight: 360,
      overlayClose: true
    });
    return $(this);
  };

})(jQuery);
