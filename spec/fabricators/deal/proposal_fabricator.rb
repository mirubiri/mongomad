Fabricator(:offer) do
  polymorphic_offer { Fabricate.build(:negotiation,offers:nil) }
  composer { Fabricate.build(:composer,polymorphic_composer:nil) }
  receiver { Fabricate.build(:receiver,polymorphic_receiver:nil) }
end