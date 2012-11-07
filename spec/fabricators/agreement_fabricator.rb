Fabricator(:agreement) do
  deal
  proposals { [Fabricate.build(:proposal)] }
  messages { [Fabricate.build(:message)] }
end