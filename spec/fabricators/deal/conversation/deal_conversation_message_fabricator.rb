Fabricator(:deal_conversation_message, class_name: "Deal::Conversation::Message") do
  transient    :user
  conversation nil
  user_id      { |attrs| attrs[:user]._id }
  text         { Faker::Lorem.sentence(word_count = 10) }
end
