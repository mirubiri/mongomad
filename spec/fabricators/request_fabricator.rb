Fabricator(:request) do
  user { Fabricate.build(:user) }
  name { |attrs| attrs[:user].nick }
  text { Faker::Lorem.sentence }
end
