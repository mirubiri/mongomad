Fabricator(:deal_conversation_message, class_name: 'Deal::Conversation::Message') do
  transient    :user
  conversation nil
  user_id      { |attrs| attrs[:user].id }
  name         { |attrs| attrs[:user].name }
  text         { Faker::Lorem.sentence }
end
