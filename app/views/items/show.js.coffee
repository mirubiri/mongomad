$('#show-item-modal').remove();
$("#ppal_container").append("<%= escape_javascript(render template: 'items/show.html', locals: {item: item}).html_safe %>");
$('#show-item-modal').toModal();
