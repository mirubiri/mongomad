Fabricator(:request) do
  user       { Fabricate(:user) }
  user_name  { |attrs| attrs[:user].profile.nickname }
  text       { Faker::Lorem.sentence(word_count = 10) }
  image_name { |attrs| attrs[:user].profile.image_name }
end
