Fabricator(:user) do
  profile { Fabricate.build(:profile,user:nil) }
  email { Faker::Internet.email }
  password 'password'
end