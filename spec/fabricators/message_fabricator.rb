Fabricator(:message) do
  polymorphic_message { Fabricate.build(:negotiation) }
  sender_id 'an existing user_sender_id'
  sender_full_name 'sender full name'
  text 'text'
end