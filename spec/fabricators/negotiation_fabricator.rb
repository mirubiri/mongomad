Fabricator(:negotiation) do
  proposals(count:10) { Fabricate.build(:proposal,polymorphic_proposal:nil,composer:Fabricate.build(:composer,_id:'el id de composer'),receiver:Fabricate.build(:receiver,_id:'el id de receiver')) }
  token_owner 'uno'
  token_state true
end