Fabricator(:proposal) do
  proposal_parent { Fabricate.build(:negotiation,proposals:nil) }
  composer { Fabricate.build(:composer,composer_parent:nil) }
  receiver { Fabricate.build(:receiver,receiver_parent:nil) }
end