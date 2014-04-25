$('#edit-negotiation-form').remove();
$("#ppal_container").append("<%= escape_javascript(render template: 'negotiations/edit_negotiation_form').html_safe %>");
$('#edit-negotiation-form').toModal();

//$(".product_overview").hide();
$('#edit-negotiation-form').previewItem();

//Cargo ademas la funcion que hace funcionar la modal.
loadOfferModalScripts();

//Ajusto los items a su padre
$('#receiver_content_area').find('.item').setItemWidth();
$('#composer_content_area').find('.item').setItemWidth();
