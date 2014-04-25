$('#edit-item-form').dialog('close');

$('#ppal_container')
.hide()
.html("<%= escape_javascript(render @items).html_safe %>")
.prepend("<%= escape_javascript(render 'no_item').html_safe %>")
.masonry('destroy');

$('#ppal_container').show();
