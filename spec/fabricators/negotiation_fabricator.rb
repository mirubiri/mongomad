Fabricator(:negotiation) do
  proposals(count:1) { Fabricate.build(:negotiation_proposal) }
  messages(count:1)  { Fabricate.build(:negotiation_message) }
end
