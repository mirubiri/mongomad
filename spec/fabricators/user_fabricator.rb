Fabricator(:user) do
  profile           { Fabricate.build(:user_profile) }
  things(count:1)   { Fabricate.build(:user_thing) }
  requests(count:1) { Fabricate.build(:request) }
  sent_offers       nil
  received_offers   nil
  negotiations      nil
  deals             nil
  email             { Faker::Internet.email }
  password          'password'
end
