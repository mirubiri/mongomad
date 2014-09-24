Fabricator(:deal) do
  transient :negotiation,:cash
  negotiation { |attrs| Fabricate.build(:negotiation,cash:attrs[:cash]) }
  user_sheets { |attrs| attrs[:negotiation].user_sheets }
  proposals { |attrs| attrs[:negotiation].proposals}
  user_ids { |attrs| attrs[:negotiation].user_ids }
end
