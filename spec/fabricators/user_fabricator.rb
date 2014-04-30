Fabricator(:user) do
  nick     { Faker::Internet.user_name.slice(0,20) }
  profile  { Fabricate.build(:profile) }
end