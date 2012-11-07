Fabricator(:message) do
  sender_id { Fabricate(:user)._id }
  sender_full_name 'a full name'
  text 'text'
end