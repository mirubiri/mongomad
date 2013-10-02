Fabricator(:request) do
  user  { Fabricate(:user) }
  user_sheet { |attrs| Fabricate.build(:user_sheet, nick:attrs[:user].nick) }
  text { Faker::Lorem.sentence }
  location  [Faker::Number.number(3),Faker::Number.number(3)] 
end
