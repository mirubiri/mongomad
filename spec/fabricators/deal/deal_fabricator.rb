Fabricator(:deal) do
  agreement { Fabricate.build(:deal_agreement) }
  messages  nil
end
