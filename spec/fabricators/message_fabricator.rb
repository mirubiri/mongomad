Fabricator(:message) do
  transient    :container
  message_container { Fabricate.build(:negotiation,messages:nil) }
  text         { Faker::Lorem.sentence }
end
