Fabricator(:deal) do
  agreement         { Fabricate.build(:deal_agreement) }
  messages(count:1) { Fabricate.build(:deal_message) }
end