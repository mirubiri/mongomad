Fabricator(:deal) do
  transient          :negotiation
  negotiation        { Fabricate(:negotiation)                                                           }
  users              { |attrs| attrs[:negotiation].users                                                 }
  agreement          { |attrs| Fabricate.build(:deal_agreement, negotiation:attrs[:negotiation])         }
  conversation       { |attrs| Fabricate.build(:deal_conversation, negotiation:attrs[:negotiation])  }
end
