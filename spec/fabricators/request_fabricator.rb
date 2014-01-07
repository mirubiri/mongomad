Fabricator(:request) do
  user       { Fabricate(:user) }
  user_sheet { |attrs| Fabricate.build(:user_sheet, nick:attrs[:user].nick) }
  text       { Faker::Lorem.sentence }
end
