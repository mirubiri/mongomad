Fabricator(:proposal) do
  polymorphic_proposal { Fabricate.build(:negotiation,proposals:nil) }
  money nil
  composer { Fabricate.build(:composer) }
  receiver { Fabricate.build(:receiver) }
end