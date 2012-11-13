Fabricator(:offer) do
  composer { Fabricate.build(:composer,polymorphic_composer:nil) }
  receiver { Fabricate.build(:receiver,polymorphic_receiver:nil) }
  initial_message 'initial message'
end