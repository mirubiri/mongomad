Fabricator(:agreement) do
  deal { Fabricate.build(:deal,agreement:nil) }
  offers(count:1) { Fabricate.build(:offer,composer:Fabricate.build(:composer,_id:'user_id'),
                                                  receiver:Fabricate.build(:receiver,_id:'user_id')) }
end