Fabricator(:negotiation) do
  transient           :offer
  offer               { Fabricate(:offer) }
  users               { |attrs| attrs[:offer].users }
  proposals(count: 1) { |attrs| Fabricate.build(:negotiation_proposal, offer:attrs[:offer]) }
  messages(count: 1)  { |attrs| Fabricate.build(:negotiation_message, composer:attrs[:offer].composer) }
end
