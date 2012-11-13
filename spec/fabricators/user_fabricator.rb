Fabricator(:user) do
  profile { Fabricate.build(:profile,user:nil) }
  things(count:5) { Fabricate.build(:thing,user:nil) }
end