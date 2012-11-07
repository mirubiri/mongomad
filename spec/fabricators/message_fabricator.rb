Fabricator(:message) do
  sender_id { Fabricate.build(:user)._id }
  sender_full_name 'sender full name'
  text 'text'
end