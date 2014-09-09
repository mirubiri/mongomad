Fabricator(:negotiation) do
  transient :offer
  offer { Fabricate.build(:offer) }
  user_sheets { |attrs| attrs[:offer].user_sheets }
  proposals { |attrs| [attrs[:offer].proposal]}
  user_ids { |attrs| attrs[:offer].user_ids }
  offer_id { |attrs| attrs[:offer].id }
end