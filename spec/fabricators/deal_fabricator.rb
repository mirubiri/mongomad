Fabricator(:deal) do
  agreement { Fabricate.build(:agreement) }
end