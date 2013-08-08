Fabricator(:request) do
  user { Fabricate.build(:user) }
  name { |attrs| attrs[:user].name }
  text { Faker::Lorem.sentence }
end
