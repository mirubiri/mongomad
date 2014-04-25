$('#edit-offer-form').remove();
$('#new-offer-form').remove();
$('#ppal-container').append("<%= escape_javascript(render :partial 'form', :layout 'as_offer_form', :locals :offer => @offer).html_safe %>");
$('#edit-offer-form').toModal();

//$(".product_overview").hide();
$('#edit-offer-form').previewItem();

//Cargo ademas la funcion que hace funcionar la modal.
loadOfferModalScripts();

//Ajusto los items a su padre
$('#receiver_content_area').find('.item').setItemWidth();
$('#composer_content_area').find('.item').setItemWidth();
