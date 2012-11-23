Fabricator(:negotiation) do
  proposals(count:1) { Fabricate.build(:proposal,proposal_parent:nil,composer:Fabricate.build(:composer,_id:'el id de composer'),receiver:Fabricate.build(:receiver,_id:'el id de receiver')) }
  messages(count:1) { Fabricate.build(:message,message_parent:nil) }
  token_user_id 'an existing token_user_id'
  token_state true
end