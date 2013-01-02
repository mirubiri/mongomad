Fabricator(:user) do
  profile         { Fabricate.build(:user_profile, user:nil) }
  things          nil
  requests        nil
  sent_offers     nil
  received_offers nil
  negotiations    nil
  deals           nil
  email           { Faker::Internet.email }
  password        'password'
end