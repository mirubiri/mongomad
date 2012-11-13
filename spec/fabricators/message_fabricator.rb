Fabricator(:message) do
  polymorphic_message { Fabricate.build(:negotiation) }
  sender_id 'user_sender_id'
  sender_full_name 'sender full name'
  text 'text'
end