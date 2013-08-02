Fabricator(:user) do
  profile         { Fabricate.build(:user_profile) }
  things          nil
  requests        nil
  sent_offers     nil
  received_offers nil
  negotiations    nil
  deals           nil
  email           { Faker::Internet.email }
  name            { Faker::Name.first_name }
  password        'password'
end

Fabricator(:user_with_things, from: :user) do
  things(count:2) { Fabricate.build(:user_thing) }
end