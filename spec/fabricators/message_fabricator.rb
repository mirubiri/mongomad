Fabricator(:message) do
  message_container { Fabricate.build(:negotiation,messages:nil) }
  user_id           { |attrs| attrs[:message_container]._users.first.id }
  text              { Faker::Lorem.sentence }
end
