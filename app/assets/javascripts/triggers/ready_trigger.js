$(document).ready(
 function() {
  setInterval(function() {
    $('#ppal_container').load(reload_comments_user_path(current_user));
  }, 2000);
});