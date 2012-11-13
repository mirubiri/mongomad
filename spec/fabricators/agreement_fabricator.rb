Fabricator(:agreement) do
  deal { Fabricate.build(:deal,agreement:nil) }
  proposals(count:10) { Fabricate.build(:proposal,composer:Fabricate.build(:composer,_id:'composer_id'),
                                                  receiver:Fabricate.build(:receiver,_id:'receiver_id')) }
end