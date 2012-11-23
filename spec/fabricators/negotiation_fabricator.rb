Fabricator(:negotiation) do
  offers(count:1) { Fabricate.build(:offer,polymorphic_offer:nil,composer:Fabricate.build(:composer,_id:'el id de composer'),receiver:Fabricate.build(:receiver,_id:'el id de receiver')) }
  messages(count:1) { Fabricate.build(:message,polymorphic_message:nil) }
  token_user_id 'an existing token_user_id'
  token_state true
end