Fabricator(:request) do
  user       { Fabricate(:user) }
  nick       { |attrs| attrs[:user].profile.nick }
  text       { Faker::Lorem.sentence(word_count = 10) }
  image_url  { |attrs| attrs[:user].profile.image_url }
end
