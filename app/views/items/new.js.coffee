$('#item_form').remove()
$("#expositor").append "<%=j render partial: 'form', layout: 'items/layouts/form_layout', locals:{ item:item } %>"
$("#item_form").toModal()
$(".cloudinary-fileupload").cloudinary_fileupload()
$(".item-image-uploader,.item-form-descriptor").equalHeightColumns()

