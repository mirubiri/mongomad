Fabricator(:message) do
  polymorphic_message { Fabricate.build(:negotiation) }
  sender_id 'an existing sender_id'
  sender_name 'sender name'
  text 'text'
end