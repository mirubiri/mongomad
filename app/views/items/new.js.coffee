$('#new-item-form').remove();
$("#ppal_container").append("<%= escape_javascript(render template: 'items/new_item_form').html_safe %>");
$('#item_image_container').attr('src', ' ');
$('#new-item-form').toModal();
