$("#leftContainer").replaceWith("<%=j render :partial => 'application/user_container' %>");
$("#navigation_bar").html("<%=j render :partial => 'application/navigation_bar' %>");

$("#ppal_container").html("<%=j render @items %>");
$("#ppal_container").prepend("<%=j render 'no_item' %>");

$('.no_elements_in_ppal').regulateWidth();

destroyMasonry();
