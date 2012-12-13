$('a[data-confirm], a[data-method], a[data-remote]').live('click.rails',function(e) {

  var link = $(this);

  if (!allowAction(link)) return false;

  if (link.attr('data-remote') !== undefined) {
    handleRemote(link);
  return false;
  } else if (link.attr('data-method')) {
    handleMethod(link);
    return false;
  }

});
