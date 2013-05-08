Fabricator(:request) do
  user { Fabricate(:user) }
  nick { |attrs| attrs[:user].profile.nick }
  text { Faker::Lorem.sentence }
end
