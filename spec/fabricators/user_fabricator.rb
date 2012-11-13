Fabricator(:user) do
  profile { Fabricate.build(:profile,user:nil) }
  things(count:5) { Fabricate.build(:thing,user:nil) }
  requests(count:1) { Fabricate.build(:request,user:nil) }
end