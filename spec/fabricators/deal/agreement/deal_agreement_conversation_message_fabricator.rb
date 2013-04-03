Fabricator(:deal_agreement_conversation_message, class_name: "Deal::Agreement::Conversation::Message") do
  transient    :message
  conversation nil
  user_id      { |attrs| attrs[:message].user_id }
  nickname     { |attrs| attrs[:message].nickname }
  text         { |attrs| attrs[:message].text }
  image_name   { |attrs| attrs[:message].image_name }
end
