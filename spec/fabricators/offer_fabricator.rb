Fabricator(:offer) do
  composer { Fabricate.build(:composer,composer_parent:nil) }
  receiver { Fabricate.build(:receiver,receiver_parent:nil) }
  initial_message 'initial message'
end