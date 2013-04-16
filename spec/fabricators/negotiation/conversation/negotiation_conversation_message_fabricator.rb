Fabricator(:negotiation_conversation_message, class_name: 'Negotiation::Conversation::Message') do
  transient    :user
  conversation nil
  user_id      { |attrs| attrs[:user]._id }
  nick         { |attrs| attrs[:user].profile.nick }
  text         { Faker::Lorem.sentence(word_count = 10) }
  image_url    { |attrs| attrs[:user].profile.image_url }
end
