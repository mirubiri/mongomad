Fabricator(:deal_conversation_message, class_name: "Deal::Conversation::Message") do
  transient    :user
  conversation nil
  user_id      { |attrs| attrs[:user]._id }
  nickname     { |attrs| attrs[:user].profile.nickname }
  text         { Faker::Lorem.sentence(word_count = 10) }
  image_name   { |attrs| attrs[:user].profile.image_name }
end
