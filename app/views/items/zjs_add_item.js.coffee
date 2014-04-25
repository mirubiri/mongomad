$('#new-item-form').dialog('close');

$('#ppal_container')
.children()
.first()
.after("<%= escape_javascript(render @item, :locals => {:item => item}).html_safe %>")
.next()
.css('opacity', 0)
.slideDown()
.animate(
  { opacity: 1 },
  { queue: false, duration: 1500 }
)
.animate({backgroundColor: '#ffffff'}, 800);
