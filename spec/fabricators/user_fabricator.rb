Fabricator(:user) do
  profile { Fabricate.build(:profile) }
  things(count:1) { Fabricate.build(:thing) }
  request(count:1) { Fabricate.build(:request) }
end