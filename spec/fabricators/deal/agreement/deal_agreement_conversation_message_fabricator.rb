Fabricator(:deal_agreement_conversation_message, class_name: 'Deal::Agreement::Conversation::Message') do
  transient    :message
  conversation nil
  user_id      { |attrs| attrs[:message].user_id }
  nick         { |attrs| attrs[:message].nick }
  text         { |attrs| attrs[:message].text }
  image_url    { |attrs| attrs[:message].image_url }
end
