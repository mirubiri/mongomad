Fabricator(:agreement) do
  deal { Fabricate.build(:deal,agreement:nil) }
  proposals(count:10) { Fabricate.build(:proposal,composer:Fabricate.build(:composer,_id:'el id de composer'),receiver:Fabricate.build(:receiver,_id:'el id de receiver')) }
end