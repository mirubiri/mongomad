Fabricator(:deal) do
  transient    :negotiation
  negotiation  { Fabricate(:negotiation) }
  signers      { |attrs| attrs[:negotiation].negotiators }
  conversation { |attrs| Fabricate.build(:deal_conversation, signers:attrs[:signers]) }
  agreement    { |attrs| Fabricate.build(:deal_agreement, negotiation:attrs[:negotiation]) }
end
