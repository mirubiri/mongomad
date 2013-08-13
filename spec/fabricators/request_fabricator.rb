Fabricator(:request) do
  user  { Fabricate.build(:user) }
  sheet do |attrs|
    Fabricate.build(:user_sheet, nick:attrs[:nick])
  end
  text { Faker::Lorem.sentence }
end
