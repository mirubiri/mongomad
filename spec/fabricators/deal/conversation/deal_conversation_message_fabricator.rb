Fabricator(:deal_conversation_message, class_name: 'Deal::Conversation::Message') do
  transient    :user
  conversation nil
  user_id      { |attrs| attrs[:user].id }
  nick         { |attrs| attrs[:user].profile.nick }
  text         { Faker::Lorem.sentence }
  image_url    { |attrs| attrs[:user].profile.image_url }
end
