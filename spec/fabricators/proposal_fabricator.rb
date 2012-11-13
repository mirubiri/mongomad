Fabricator(:proposal) do
  polymorphic_proposal { Fabricate.build(:negotiation,proposals:nil) }
  money nil
  composer { Fabricate.build(:composer,polymorphic_composer:nil) }
  receiver { Fabricate.build(:receiver,polymorphic_receiver:nil) }
end