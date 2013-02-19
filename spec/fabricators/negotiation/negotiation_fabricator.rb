Fabricator(:negotiation) do
  transient :offer
  offer               { Fabricate(:offer)                                                              }
  negotiators         { |attrs| [ attrs[:offer].user_composer, attrs[:offer].user_receiver ]           }
  proposals(count: 1) { |attrs| Fabricate.build(:negotiation_proposal, offer:attrs[:offer])            }
  conversation        { |attrs| Fabricate.build(:negotiation_conversation, offer:attrs[:offer])        }
end
