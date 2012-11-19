Fabricator(:user) do
  profile { Fabricate.build(:profile,user:nil) }
  things(count:5) { Fabricate.build(:thing,user:nil) }
  email { Faker::Internet.email }
  password 'password'
end