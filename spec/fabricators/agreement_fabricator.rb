Fabricator(:agreement) do
  proposals { [Fabricate.build(:proposal)] }
  messages { [Fabricate.build(:message)] }
end