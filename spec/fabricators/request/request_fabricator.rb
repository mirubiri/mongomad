Fabricator(:request) do
  user { Fabricate(:user) }
  name { |attrs| attrs[:user].name }
  text { Faker::Lorem.sentence }
end
