Fabricator(:user) do
  profile nil
  things nil
  email { Faker::Internet.email }
  password 'password'
  received_offers nil
  sent_offers nil
  negotiations nil
  deals nil
  request nil
end