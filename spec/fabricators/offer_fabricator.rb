Fabricator(:offer) do
  initial_message 'initial message'
  composer { Fabricate.build(:composer,polymorphic_composer:nil) }
  receiver { Fabricate.build(:receiver,polymorphic_receiver:nil) }
end