Fabricator(:message) do
  polymorphic_message { Fabricate.build(:negotiation) }
  sender_id { Fabricate.build(:user)._id }
  sender_full_name 'sender full name'
  text 'text'
end