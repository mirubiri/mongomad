$('#new-proposal').remove()
$("#expositor").append "<%=j render partial: 'proposal/offer_form', layout: 'proposal/layouts/offer', locals:{ offer:offer } %>"
$("#new-proposal").toModal()
