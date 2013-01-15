Fabricator(:deal) do
  transient           :negotiation
  negotiation         { Fabricate.build(:negotiation) }
  users               { |attrs| attrs[:offer].users }
  agreement(count: 1) { |attrs| Fabricate.build(:deal_agreement, negotiation:attrs[:negotiation]) }
  messages(count: 1)  { |attrs| Fabricate.build(:deal_message, negotiation:attrs[:negotiation]) }
end
