$('#item_form').remove()
$("#elements_list").append("<%= escape_javascript(render partial: 'form', layout: 'items/layouts/form_layout', locals:{ item:item }).html_safe %>")
$('#item_form').toModal()
