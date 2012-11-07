Fabricator(:proposal) do
  composer { Fabricate.build(:composer) }
  receiver { Fabricate.build(:receiver) }
end