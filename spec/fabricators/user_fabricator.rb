Fabricator(:user) do
  profile nil
  things nil
  request nil
  sent_offers nil
  received_offers nil
  negotiations nil
  deals nil
  email { Faker::Internet.email }
  encrypted_password 'encrypted_password'
end