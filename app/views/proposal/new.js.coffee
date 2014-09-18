alert "esto funciona"

$('#new_proposal').remove()
$("#expositor").append "<%=j render template: 'new' %>"
$("#new_proposal").toModal()
