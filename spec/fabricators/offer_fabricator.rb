Fabricator(:offer) do
  composer { Fabricate.build(:composer) }
  receiver { Fabricate.build(:receiver) }
  money { Fabricate.build(:money) }
  initial_message 'initial message'
end