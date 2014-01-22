Fabricator(:message) do
  transient :user

  user  { Fabricate(:user_with_items) }

  message_container { |attrs| Fabricate.build(:negotiation, messages:nil, offer:Fabricate.build(:offer, user_composer:attrs[:user], user_receiver:Fabricate.build(:user_with_items)), messages:nil) }

  user_id           { |attrs| attrs[:user]._id }
  text              { Faker::Lorem.sentence }
end
