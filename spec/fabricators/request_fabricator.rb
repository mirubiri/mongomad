Fabricator(:request) do
  user       { Fabricate(:user) }
  user_sheet { |attrs| Fabricate.build(:user_sheet, user:attrs[:user]) }
  text       { Faker::Lorem.sentence }
end
