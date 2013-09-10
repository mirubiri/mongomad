Fabricator(:message) do
  message_container { Fabricate.build(:negotiation,messages:nil) }
  text         { Faker::Lorem.sentence }
end
