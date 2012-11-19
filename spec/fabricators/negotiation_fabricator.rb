Fabricator(:negotiation) do
  proposals(count:10) { Fabricate.build(:proposal,polymorphic_proposal:nil,composer:Fabricate.build(:composer,_id:'el id de composer'),receiver:Fabricate.build(:receiver,_id:'el id de receiver')) }
  messages(count:1) { Fabricate.build(:message,polymorphic_message:nil) }
  token_user_id 'an existing token_user_id'
  token_state true
end