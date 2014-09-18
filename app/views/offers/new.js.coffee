$('#new_proposal').remove()
$("#expositor").append "<%=j render template: 'proposal/new' %>"
$("#new_proposal").toModal()
