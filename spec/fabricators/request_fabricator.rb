Fabricator(:user_request, class_name: 'User::Request') do
  user_id 'an existing user_id'
  user_name 'owner name'
  text 'text'
end