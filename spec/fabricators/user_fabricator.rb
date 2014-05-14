Fabricator(:user) do
  nick     { Faker::Internet.user_name }
  password '00000000'
  email { Faker::Internet.safe_email }
  profile  { Fabricate.build(:profile) }
end