$('#new-offer-form').remove();
$("#ppal_container").append("<%= escape_javascript(render partial: 'form', :layout 'as_offer_form').html_safe %>");
$('#new-offer-form').toModal();

//$(".product_overview").hide();
$('#new-offer-form').previewItem();

//Cargo ademas la funcion que hace funcionar la modal.
loadOfferModalScripts();

//Ajusto los items a su padre
$('#receiver_content_area').find('.item').setItemWidth();
$('#composer_content_area').find('.item').setItemWidth();
