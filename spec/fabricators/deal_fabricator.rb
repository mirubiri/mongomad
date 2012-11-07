Fabricator(:deal) do
  agreement { Fabricate.build(:agreement) }
  messages { [Fabricate.build(:message)] }
end