Fabricator(:user) do
  profile         { Fabricate.build(:user_profile) }
  things          nil
  requests        nil
  sent_offers     nil
  received_offers nil
  negotiations    nil
  deals           nil
  email           { Faker::Internet.safe_email }
  password        'password'
end

Fabricator(:user_with_things, from: :user) do
	things(count:1) { Fabricate.build(:user_thing) }
end