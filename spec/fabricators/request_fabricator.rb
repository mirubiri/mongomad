Fabricator(:request) do
  user  { Fabricate.build(:user) }
  sheet { |attrs| Fabricate.build(:user_sheet, nick:attrs[:user].nick) }
  text { Faker::Lorem.sentence }
end
