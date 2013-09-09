=begin
Fabricator(:deal) do
   transient    :negotiation
   negotiation  { Fabricate(:negotiation) }
   signers      { |attrs| attrs[:negotiation].negotiators }
   conversation { |attrs| Fabricate.build(:deal_conversation, user:attrs[:signers].first) }
   agreement    { |attrs| Fabricate.build(:deal_agreement, negotiation:attrs[:negotiation]) }
end
=end
