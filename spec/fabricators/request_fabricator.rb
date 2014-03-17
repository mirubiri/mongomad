Fabricator(:request) do
  user       { Fabricate(:user) }
  user_sheet { |attrs| Fabricate.build(:user_sheet, user:attrs[:user]) }
  text       { Faker::Lorem.sentence(rand(1..40)).slice(0,160) }
end
