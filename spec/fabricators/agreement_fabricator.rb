Fabricator(:agreement) do
  deal { Fabricate.build(:deal,agreement:nil) }
  proposals(count:10) { Fabricate.build(:proposal,composer:Fabricate.build(:composer,_id:'user_id'),
                                                  receiver:Fabricate.build(:receiver,_id:'user_id')) }
end