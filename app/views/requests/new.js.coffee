$("#new-request-form").remove()

$("#add_request_invitation").addClass "hidden_container"

$("#ppal_container").append "<%= escape_javascript(render template: 'requests/new_request_form').html_safe %>"

$("#new-request-form").toModal()
