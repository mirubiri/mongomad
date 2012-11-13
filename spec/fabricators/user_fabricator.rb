Fabricator(:user) do
  profile { Fabricate.build(:profile) }
  things(count:1) { Fabricate.build(:thing) }
  requests(count:1) { Fabricate.build(:request) }
end